package service;

import entity.CandidatRefuseDetails;
import repository.CandidatRefuseDetailsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CandidatRefuseDetailsService {

    @Autowired
    private CandidatRefuseDetailsRepository repository;

    // ===== Récupérer tous les candidats refusés =====
    public List<CandidatRefuseDetails> findAll() {
        return repository.findAll();
    }

    // ===== Récupérer par étape de refus =====
    public List<CandidatRefuseDetails> findByLibelleEtape(String libelleEtape) {
        return repository.findByLibelleEtape(libelleEtape);
    }

    // ===== Récupérer par département =====
    public List<CandidatRefuseDetails> findByDepartement(String departement) {
        return repository.findByDepartement(departement);
    }

    // ===== Récupérer par diplôme =====
    public List<CandidatRefuseDetails> findByDiplome(String diplome) {
        return repository.findByDiplome(diplome);
    }

    // ===== Rechercher par nom ou prénom =====
    public List<CandidatRefuseDetails> searchByNomOrPrenom(String searchTerm) {
        return repository.findByNomContainingIgnoreCaseOrPrenomContainingIgnoreCase(searchTerm, searchTerm);
    }

    // ===== Compter par étape de refus =====
    public long countByLibelleEtape(String libelleEtape) {
        return repository.countByLibelleEtape(libelleEtape);
    }

    // ===== Récupérer les étapes de refus distinctes =====
    public List<String> getDistinctLibelleEtape() {
        return repository.findDistinctLibelleEtape();
    }

    // ===== Récupérer par ID =====
    public CandidatRefuseDetails findById(Integer id) {
        return repository.findById(id).orElse(null);
    }
}