package service;

import entity.VueSoldeConges;
import repository.VueSoldeCongesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class VueSoldeCongesService {

    @Autowired
    private VueSoldeCongesRepository vueSoldeCongesRepository;

    public List<VueSoldeConges> findAll() {
        return vueSoldeCongesRepository.findAllByOrderByDepartementAscNomAsc();
    }
    
    public List<VueSoldeConges> findByDepartement(String departement) {
        return vueSoldeCongesRepository.findByDepartementOrderByNomAsc(departement);
    }
    
    public List<VueSoldeConges> findByAnnee(Integer annee) {
        return vueSoldeCongesRepository.findByAnneeOrderByDepartementAscNomAsc(annee);
    }
    
    public VueSoldeConges findByEmployeId(Integer employeId) {
        return vueSoldeCongesRepository.findByEmployeId(employeId);
    }
    
    public List<VueSoldeConges> findSoldesNegatifs() {
        return vueSoldeCongesRepository.findSoldesNegatifs();
    }
    
    public List<VueSoldeConges> findByAnneeAndDepartement(Integer annee, String departement) {
        return vueSoldeCongesRepository.findByAnneeAndDepartement(annee, departement);
    }
    
    // Méthode pour les statistiques
    public String getStatistiques() {
        Object[] stats = vueSoldeCongesRepository.getStatistiquesGlobales();
        if (stats != null && stats.length >= 4) {
            Long count = (Long) stats[0];
            Double moyenne = (Double) stats[1];
            Integer min = (Integer) stats[2];
            Integer max = (Integer) stats[3];
            
            return String.format("%,d employés | Moyenne: %.1f j | Min: %d j | Max: %d j", 
                count, moyenne, min, max);
        }
        return "Aucune statistique disponible";
    }
}