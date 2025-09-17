package service;

import entity.Candidat;
import repository.CandidatRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CandidatService {

    private final CandidatRepository candidatRepository;

    public CandidatService(CandidatRepository candidatRepository) {
        this.candidatRepository = candidatRepository;
    }

    // Ajouter un candidat
    public Candidat addCandidat(Candidat candidat) {
        return candidatRepository.save(candidat);
    }

    // Récupérer tous les candidats
    public List<Candidat> getAllCandidats() {
        return candidatRepository.findAll();
    }

    // Récupérer un candidat par son ID
    public Optional<Candidat> getCandidatById(Integer id) {
        return candidatRepository.findById(id);
    }

    // Mettre à jour un candidat
    public Candidat updateCandidat(Candidat candidat) {
        return candidatRepository.save(candidat);
    }

    // Supprimer un candidat
    public void deleteCandidat(Integer id) {
        candidatRepository.deleteById(id);
    }


    // Login
    public Optional<Candidat> login(String mail, String prenom) {
        return candidatRepository.findByMailAndPrenom(mail, prenom);
    }
}
