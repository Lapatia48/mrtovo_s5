package service;

import entity.PointageEmploye;
import repository.PointageEmployeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

// IMPORTS MANQUANTS
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@Service
public class PointageEmployeService {

    @Autowired
    private PointageEmployeRepository pointageEmployeRepository;

    public PointageEmploye creerPointage(
            Integer employeId, String typeEvenement, String sousType, 
            String dateEvenement, Double dureeJours, 
            Integer heuresRetard, Integer minutesRetard, String motif) {
        
        PointageEmploye pointage = new PointageEmploye();
        pointage.setIdEmploye(employeId);
        pointage.setTypeEvenement(typeEvenement);
        pointage.setSousType(sousType);
        pointage.setDateEvenement(LocalDate.parse(dateEvenement));
        pointage.setMotif(motif);
        
        // Calculer les impacts selon le type
        calculerImpacts(pointage, dureeJours, heuresRetard, minutesRetard);
        
        return pointageEmployeRepository.save(pointage);
    }
    
    private void calculerImpacts(PointageEmploye pointage, Double dureeJours, 
                                Integer heuresRetard, Integer minutesRetard) {
        
        String type = pointage.getTypeEvenement();
        String sousType = pointage.getSousType();
        
        switch (type) {
            case "absence":
                pointage.setDureeJours(dureeJours);
                if ("justifiee".equals(sousType)) {
                    pointage.setImpactExceptionnel(dureeJours); // Absence justifiée → quota exceptionnel
                } else {
                    pointage.setImpactAnnuel(dureeJours); // Absence non justifiée → quota annuel
                }
                break;
                
            case "retard":
                int totalMinutes = (heuresRetard != null ? heuresRetard * 60 : 0) + 
                                  (minutesRetard != null ? minutesRetard : 0);
                double equivalentJours = (totalMinutes / 60.0) * 0.125; // 1h = 0.125 jour
                pointage.setHeuresRetard(totalMinutes);
                pointage.setEquivalentJours(equivalentJours);
                pointage.setImpactExceptionnel(equivalentJours); // Retard → quota exceptionnel
                break;
                
            case "maladie":
                pointage.setDureeJours(dureeJours);
                pointage.setImpactExceptionnel(dureeJours); // Maladie → quota exceptionnel
                break;
                
            case "mission":
                pointage.setDureeJours(dureeJours);
                pointage.setImpactAnnuel(dureeJours); // Mission → quota annuel
                break;
        }
    }
    
    // Méthodes supplémentaires utiles
    public List<PointageEmploye> getPointagesByEmploye(Integer employeId) {
        return pointageEmployeRepository.findByIdEmploye(employeId);
    }
    
    public List<PointageEmploye> getPointagesByType(String typeEvenement) {
        return pointageEmployeRepository.findByTypeEvenement(typeEvenement);
    }
    
    public List<PointageEmploye> getPointagesPeriode(LocalDate debut, LocalDate fin) {
        return pointageEmployeRepository.findByDateEvenementBetween(debut, fin);
    }
    
    // Récupérer l'impact total d'un employé
    public Map<String, Double> getImpactsTotaux(Integer employeId) {
        List<PointageEmploye> pointages = getPointagesByEmploye(employeId);
        
        double totalImpactAnnuel = pointages.stream()
            .mapToDouble(p -> p.getImpactAnnuel() != null ? p.getImpactAnnuel() : 0.0)
            .sum();
            
        double totalImpactExceptionnel = pointages.stream()
            .mapToDouble(p -> p.getImpactExceptionnel() != null ? p.getImpactExceptionnel() : 0.0)
            .sum();
        
        Map<String, Double> impacts = new HashMap<>();
        impacts.put("annuel", totalImpactAnnuel);
        impacts.put("exceptionnel", totalImpactExceptionnel);
        
        return impacts;
    }
}