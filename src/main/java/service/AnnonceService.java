package service;

import entity.Annonce;
import repository.AnnonceRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.Period;
import java.util.List;
import java.util.Optional;

@Service
public class AnnonceService {

    private final AnnonceRepository annonceRepository;

    public AnnonceService(AnnonceRepository annonceRepository) {
        this.annonceRepository = annonceRepository;
    }

    public List<Annonce> getAllAnnonces() {
        return annonceRepository.findAll();
    }

    public Optional<Annonce> getAnnonceById(Long id) {
        return annonceRepository.findById(id);
    }

    public Annonce save(Annonce annonce) {
        return annonceRepository.save(annonce);
    }

    public void deleteAnnonce(Long id) {
        annonceRepository.deleteById(id);
    }

    public Annonce updateAnnonce(Annonce annonce) {
        return annonceRepository.save(annonce);
    }
    
    public boolean checkCV(LocalDate dateNaissance, Integer idAnnonce) {
    //  Récupérer l'annonce
    Optional<Annonce> annonceOpt = annonceRepository.findById((long) idAnnonce); // cast Integer -> Long
    if (annonceOpt.isEmpty()) {
        return false; // annonce introuvable
    }
    Annonce annonce = annonceOpt.get();

    //  Calculer l'âge du candidat
    int ageCandidat = Period.between(dateNaissance, LocalDate.now()).getYears();

    //  Comparer avec l'âge min/max de l'annonce
    if (annonce.getAgeMin() != null && annonce.getAgeMax() != null) {
        return ageCandidat >= annonce.getAgeMin() && ageCandidat <= annonce.getAgeMax();
    }

    // Si pas d'ageMin ou ageMax défini, retourner false
        return false;
    }
}
