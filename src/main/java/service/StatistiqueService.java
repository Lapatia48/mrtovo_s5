package service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import repository.ContratRepository;
import repository.EmployeRepository;

@Service
public class StatistiqueService {
    
    @PersistenceContext
    private EntityManager entityManager;
    
    @Autowired
    private EmployeRepository employeRepository;
    
    @Autowired
    private ContratRepository contratRepository;
    
    // === STATISTIQUES GLOBALES ===
    
    public Map<String, Long> getEffectifParDepartement() {
        List<Object[]> results = employeRepository.countEmployesByDepartement();
        return convertToMap(results);
    }
    
    public Map<String, Long> getEffectifParTrancheAge() {
        List<Object[]> results = employeRepository.countEmployesByTrancheAge();
        return convertToMap(results);
    }
    
    public Map<String, Long> getEffectifParTypeContrat() {
        List<Object[]> results = contratRepository.countEmployesByTypeContrat();
        return convertToMap(results);
    }
    
    public Double getAncienneteMoyenne() {
        Double anciennete = employeRepository.findAncienneteMoyenne();
        return anciennete != null ? Math.round(anciennete * 10.0) / 10.0 : 0.0;
    }
    
    public Long getEffectifTotal() {
        return employeRepository.countEmployesActifs();
    }
    
    // === TURNOVER & ABSENTÉISME (avec EntityManager) ===
    
    public Map<String, Object> getTauxTurnover() {
        String sql = """
            SELECT 
                COUNT(*) FILTER (WHERE statut != 'actif' AND date_embauche >= CURRENT_DATE - INTERVAL '12 months') as departs,
                COUNT(*) FILTER (WHERE date_embauche >= CURRENT_DATE - INTERVAL '12 months') as embauches_total,
                ROUND(
                    CAST(COUNT(*) FILTER (WHERE statut != 'actif' AND date_embauche >= CURRENT_DATE - INTERVAL '12 months') * 100.0 / 
                    NULLIF(COUNT(*) FILTER (WHERE date_embauche >= CURRENT_DATE - INTERVAL '12 months'), 0) AS NUMERIC)
                , 1) as taux_turnover_pourcent
            FROM employe 
            """;
        try {
            Query query = entityManager.createNativeQuery(sql);
            List<Object[]> results = query.getResultList();
            
            if (results != null && !results.isEmpty()) {
                Object[] result = results.get(0);
                Map<String, Object> turnover = new HashMap<>();
                turnover.put("departs", ((Number) result[0]).longValue());      
                turnover.put("embauchesTotal", ((Number) result[1]).longValue()); 
                turnover.put("tauxPourcent", result[2]);                        
                return turnover;
            }
        } catch (Exception e) {
            System.err.println("Erreur lors du calcul du turnover: " + e.getMessage());
        }
        return Map.of("departs", 0L, "embauchesTotal", 0L, "tauxPourcent", 0.0);
    }
    
    
    public List<Map<String, Object>> getHistoriqueTurnover() {
        String sql = """
            SELECT 
                EXTRACT(YEAR FROM date_embauche) as annee,
                COUNT(*) FILTER (WHERE statut != 'actif') as departs,
                COUNT(*) as embauches_total,
                ROUND(
                    CAST(COUNT(*) FILTER (WHERE statut != 'actif') * 100.0 / 
                    NULLIF(COUNT(*), 0) AS NUMERIC)
                , 1) as taux_turnover_pourcent
            FROM employe 
            GROUP BY EXTRACT(YEAR FROM date_embauche)
            ORDER BY annee DESC
            """;
        
        try {
            Query query = entityManager.createNativeQuery(sql);
            List<Object[]> results = query.getResultList();
            
            List<Map<String, Object>> historique = new ArrayList<>();
            for (Object[] result : results) {  
                Map<String, Object> anneeData = new HashMap<>();
                anneeData.put("annee", ((Number) result[0]).intValue());        
                anneeData.put("departs", ((Number) result[1]).longValue());     
                anneeData.put("embauchesTotal", ((Number) result[2]).longValue()); 
                anneeData.put("tauxPourcent", result[3]);                     
                historique.add(anneeData);
            }
            return historique;
        } catch (Exception e) {
            System.err.println("Erreur lors du calcul de l'historique turnover: " + e.getMessage());
        }
        return Collections.emptyList();
    }

    public Map<String, Object> getTauxAbsenteisme() {
        String sql = """
            SELECT 
                COUNT(DISTINCT pe.id_employe) as employes_absents,
                (SELECT COUNT(*) FROM employe WHERE statut = 'actif') as effectif_total,
                CASE 
                    WHEN (SELECT COUNT(*) FROM employe WHERE statut = 'actif') > 0 THEN
                        ROUND(
                            CAST(COUNT(DISTINCT pe.id_employe) * 100.0 / 
                            (SELECT COUNT(*) FROM employe WHERE statut = 'actif') AS NUMERIC)
                        , 1)
                    ELSE 0.0
                END as taux_absenteisme_pourcent
            FROM pointage_employe pe
            WHERE pe.date_evenement >= CURRENT_DATE - INTERVAL '30 days'
            AND pe.type_evenement IN ('absence', 'maladie')
            AND pe.statut = 'valide'
            """;
        
        try {
            Query query = entityManager.createNativeQuery(sql);
            List<Object[]> results = query.getResultList();
            
            if (results != null && !results.isEmpty()) {
                Object[] result = results.get(0);
                Map<String, Object> absenteisme = new HashMap<>();
                absenteisme.put("employesAbsents", ((Number) result[0]).longValue());
                absenteisme.put("effectifTotal", ((Number) result[1]).longValue());
                absenteisme.put("tauxPourcent", result[2]);
                
                System.out.println("DEBUG Absentéisme - Absents: " + result[0] + ", Total: " + result[1] + ", Taux: " + result[2]);
                
                return absenteisme;
            }
        } catch (Exception e) {
            System.err.println("Erreur lors du calcul de l'absentéisme: " + e.getMessage());
            e.printStackTrace();
        }
        return Map.of("employesAbsents", 0L, "effectifTotal", 0L, "tauxPourcent", 0.0);
    }
    
    public List<Map<String, Object>> getDetailsAbsencesParEmploye() {
        String sql = """
            SELECT 
                e.id,
                e.nom,
                e.prenom,
                e.departement,
                COALESCE(SUM(pe.duree_jours), 0) as jours_absence
            FROM employe e
            LEFT JOIN pointage_employe pe ON e.id = pe.id_employe
                AND pe.date_evenement >= CURRENT_DATE - INTERVAL '30 days'
                AND pe.type_evenement IN ('absence', 'maladie')
                AND pe.statut = 'valide'
            WHERE e.statut = 'actif'
            GROUP BY e.id, e.nom, e.prenom, e.departement
            HAVING COALESCE(SUM(pe.duree_jours), 0) > 0
            ORDER BY jours_absence DESC
            """;
        
        try {
            Query query = entityManager.createNativeQuery(sql);
            List<Object[]> results = query.getResultList();
            
            List<Map<String, Object>> details = new ArrayList<>();
            for (Object[] result : results) {
                Map<String, Object> detail = new HashMap<>();
                detail.put("id", ((Number) result[0]).longValue());
                detail.put("nom", result[1]);
                detail.put("prenom", result[2]);
                detail.put("departement", result[3]);
                detail.put("joursAbsence", ((Number) result[4]).doubleValue());
                details.add(detail);
            }
            
            System.out.println("DEBUG Détails absences - Nombre d'employés: " + details.size());
            return details;
        } catch (Exception e) {
            System.err.println("Erreur lors du chargement des détails d'absences: " + e.getMessage());
            e.printStackTrace();
            return Collections.emptyList();
        }
    }
        
    // Méthode utilitaire
    private Map<String, Long> convertToMap(List<Object[]> results) {
        Map<String, Long> map = new HashMap<>();
        if (results != null) {
            for (Object[] result : results) {
                if (result.length >= 2 && result[0] != null && result[1] != null) {
                    map.put((String) result[0], ((Number) result[1]).longValue());
                }
            }
        }
        return map;
    }
}