package service;

import entity.AnnonceDetailCandidat;
import repository.AnnonceDetailCandidatRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class AnnonceDetailCandidatService {

    @Autowired
    private AnnonceDetailCandidatRepository annonceDetailCandidatRepository;

    public Optional<AnnonceDetailCandidat> findByIdCandidat(Integer idCandidat) {
        return annonceDetailCandidatRepository.findByCandidatId(idCandidat);
    }

    // Pas de save() pour une vue - lecture seule
    public AnnonceDetailCandidat findById(Integer id) {
        return annonceDetailCandidatRepository.findById(id).orElse(null);
    }
}