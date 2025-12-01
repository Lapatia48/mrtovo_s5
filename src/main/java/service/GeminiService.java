package service;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;

import config.GeminiConfig;

@Service
public class GeminiService {

    @Autowired
    private DataSource dataSource;

    @Autowired
    private GeminiConfig geminiConfig;
    
    @Autowired
    private RestTemplate restTemplate;

    private static final Logger logger = Logger.getLogger(GeminiService.class.getName());

    public String processQuestion(String question) {
        try {
            Set<String> tableNames = getAllTableNames();
            
            System.out.println("🔍 Tables trouvées dans la base tovo_s5:");
            tableNames.forEach(table -> System.out.println("- " + table));
            
            Map<String, List<Map<String, Object>>> allData = new HashMap<>();
            for (String tableName : tableNames) {
                allData.put(tableName, getSampleData(tableName));
            }

            return queryGemini(question, allData);
        } catch (Exception e) {
            e.printStackTrace();
            return "❌ Erreur lors du traitement de votre question.";
        }
    }

    private Set<String> getAllTableNames() throws Exception {
        Set<String> tableNames = new HashSet<>();
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        
        String sql = "SELECT table_name FROM information_schema.tables WHERE table_catalog = 'tovo_s5' AND table_schema = 'public' AND table_type = 'BASE TABLE'";
        
        jdbcTemplate.query(sql, rs -> {
            tableNames.add(rs.getString("table_name"));
        });
        
        return tableNames;
    }

    private List<Map<String, Object>> getSampleData(String tableName) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        String sql = String.format("SELECT * FROM %s", tableName);
        return jdbcTemplate.queryForList(sql);
    }

    private String queryGemini(String question, Map<String, List<Map<String, Object>>> data) {
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            // ✅ SOLUTION 1: Utilise DIRECTEMENT l'URL de GeminiConfig
            logger.info("🚀 Appel API Gemini: " + geminiConfig.getApiUrl());
            
            // ✅ SOLUTION 2: Structure de requête SIMPLIFIÉE
            Map<String, Object> requestBody = new HashMap<>();
            Map<String, Object> content = new HashMap<>();
            
            // Construction directe sans méthode séparée
            Map<String, Object> part = new HashMap<>();
            part.put("text", "Tu es un expert en bases de données. Analyse ces données et réponds en français sans nous doner les contenues des tables mais juste de quelles tables tu les tire.\n\n" +
                            "DONNÉES: " + data.toString() + "\n\n" +
                            "QUESTION: " + question);
            
            content.put("parts", List.of(part));
            requestBody.put("contents", List.of(content));
            
            // Configuration simple
            Map<String, Object> generationConfig = new HashMap<>();
            generationConfig.put("temperature", 0.7);
            generationConfig.put("maxOutputTokens", 1024);
            requestBody.put("generationConfig", generationConfig);

            HttpEntity<Map<String, Object>> request = new HttpEntity<>(requestBody, headers);

            // ✅ SOLUTION 3: Appel API avec gestion d'erreur améliorée
            Map<String, Object> response = restTemplate.postForObject(
                geminiConfig.getApiUrl(), // URL depuis la config
                request,
                Map.class
            );

            logger.info("📥 Réponse brute: " + response);

            // ✅ SOLUTION 4: Extraction SIMPLE et ROBUSTE
            if (response != null) {
                // Vérifie d'abord les erreurs
                if (response.containsKey("error")) {
                    Map<String, Object> error = (Map<String, Object>) response.get("error");
                    String errorMsg = (String) error.get("message");
                    logger.severe("❌ Erreur Gemini: " + errorMsg);
                    return "Erreur Gemini: " + errorMsg;
                }
                
                // Extraction normale
                if (response.containsKey("candidates")) {
                    List<Map<String, Object>> candidates = (List<Map<String, Object>>) response.get("candidates");
                    if (candidates != null && !candidates.isEmpty()) {
                        Map<String, Object> firstCandidate = candidates.get(0);
                        Map<String, Object> contentResponse = (Map<String, Object>) firstCandidate.get("content");
                        List<Map<String, Object>> parts = (List<Map<String, Object>>) contentResponse.get("parts");
                        
                        if (parts != null && !parts.isEmpty()) {
                            String text = (String) parts.get(0).get("text");
                            logger.info("✅ Réponse Gemini: " + text);
                            return text;
                        }
                    }
                }
            }
            
            // Fallback si réponse invalide
            return generateLocalAnalysis(data);
            
        } catch (HttpStatusCodeException e) {
            // ✅ Gestion d'erreur HTTP améliorée
            logger.log(Level.SEVERE, "❌ Erreur HTTP " + e.getRawStatusCode() + ": " + e.getResponseBodyAsString());
            
            if (e.getRawStatusCode() == 404) {
                return "❌ Modèle Gemini non trouvé. Vérifie la configuration.";
            } else if (e.getRawStatusCode() == 403) {
                return "❌ Clé API invalide ou permissions insuffisantes.";
            } else {
                return "❌ Erreur Gemini: " + e.getRawStatusCode() + " - " + e.getStatusText();
            }
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "💥 Erreur inattendue", e);
            return generateLocalAnalysis(data);
        }
    }

    // ✅ Fallback local SIMPLIFIÉ
    private String generateLocalAnalysis(Map<String, List<Map<String, Object>>> data) {
        StringBuilder response = new StringBuilder();
        response.append("🤖 **Analyse Locale**\n\n");
        response.append("Votre base contient ").append(data.size()).append(" tables:\n");
        
        data.forEach((table, rows) -> {
            response.append("• ").append(table).append(": ").append(rows.size()).append(" enregistrements\n");
        });
        
        return response.toString();
    }
}