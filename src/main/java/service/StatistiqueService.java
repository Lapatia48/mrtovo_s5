package service;

import java.util.ArrayList;
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

    public Map<String, Object> getTauxAbsenteisme() {
        String sql = """
            SELECT 
                COUNT(DISTINCT id_employe) as employes_absents,
                (SELECT COUNT(*) FROM employe WHERE statut = 'actif') as effectif_total,
                ROUND(
                    CAST(COUNT(DISTINCT id_employe) * 100.0 / 
                    NULLIF((SELECT COUNT(*) FROM employe WHERE statut = 'actif'), 0) AS NUMERIC)
                , 1) as taux_absenteisme_pourcent
            FROM pointage_employe 
            WHERE type_evenement = 'absence' 
                AND EXTRACT(MONTH FROM date_evenement) = EXTRACT(MONTH FROM CURRENT_DATE)
                AND EXTRACT(YEAR FROM date_evenement) = EXTRACT(YEAR FROM CURRENT_DATE)
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
                return absenteisme;
            }
        } catch (Exception e) {
            System.err.println("Erreur lors du calcul de l'absentéisme: " + e.getMessage());
        }
        return Map.of("employesAbsents", 0L, "effectifTotal", 0L, "tauxPourcent", 0.0);
    }

    public List<Map<String, Object>> getDetailsAbsencesParEmploye() {
        String sql = """
            SELECT 
                e.nom,
                e.prenom,
                e.departement,
                COALESCE(SUM(pe.duree_jours), 0) as jours_absence_mois
            FROM employe e
            LEFT JOIN pointage_employe pe ON e.id = pe.id_employe 
                AND pe.type_evenement = 'absence'
                AND EXTRACT(MONTH FROM pe.date_evenement) = EXTRACT(MONTH FROM CURRENT_DATE)
                AND EXTRACT(YEAR FROM pe.date_evenement) = EXTRACT(YEAR FROM CURRENT_DATE)
            WHERE e.statut = 'actif'
            GROUP BY e.id, e.nom, e.prenom, e.departement
            ORDER BY jours_absence_mois DESC
            """;
        
        try {
            Query query = entityManager.createNativeQuery(sql);
            List<Object[]> results = query.getResultList();
            
            List<Map<String, Object>> absences = new ArrayList<>();
            if (results != null) {
                for (Object[] result : results) {
                    Map<String, Object> absence = new HashMap<>();
                    absence.put("nom", result[0] != null ? result[0] : "N/A");
                    absence.put("prenom", result[1] != null ? result[1] : "N/A");
                    absence.put("departement", result[2] != null ? result[2] : "N/A");
                    absence.put("joursAbsence", result[3] != null ? ((Number) result[3]).doubleValue() : 0.0);
                    absences.add(absence);
                }
            }
            return absences;
        } catch (Exception e) {
            System.err.println("Erreur lors du chargement des absences: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    public List<Map<String, Object>> getHistoriqueTurnover() {
        // Pour l'instant, retournez une liste vide
        // Vous pourrez implémenter cette fonctionnalité plus tard
        return new ArrayList<>();
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