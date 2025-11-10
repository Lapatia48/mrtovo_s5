package service;

import entity.Congee;
import jakarta.transaction.Transactional;
import repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Transactional
@Service
public class CongeeService {

    @Autowired
    private CongeeRepository congeeRepository;

    @Autowired
    private CongeEtatRepository congeEtatRepository;

    public Integer getQuotaRestant(Integer idEmploye, Integer annee) {
    // Récupère le quota total pour l'année
    Congee congee = congeeRepository.findByIdEmployeAndAnnee(idEmploye, annee);
    if (congee == null) {
        return null; // Ou créer un quota par défaut si nécessaire
    }
    
    // Récupère la somme des durées des congés approuvés pour cette année
    Integer joursPris = congeEtatRepository.sumDureeByEmployeAndAnneeAndStatut(idEmploye, annee, "approuve");
        
        return congee.getQuota() - (joursPris != null ? joursPris : 0);
    }

    @Transactional
    public void updateQuota(Integer idEmploye, Integer duree) {
        congeeRepository.updateQuota(idEmploye, duree);
    }
}