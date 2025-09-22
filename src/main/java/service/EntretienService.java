package service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Optional;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import entity.Annonce;
import entity.Candidat;
import entity.Entretien;
import repository.AnnonceRepository;
import repository.CandidatRepository;
import repository.EntretienRepository;


 @Service
public class EntretienService {

    @Autowired
    private EntretienRepository entretienRepo;

    @Autowired
    private CandidatRepository candidatRepo;

    @Autowired
    private AnnonceRepository annonceRepo;

    public boolean existsEntretien(Integer idCandidat) {
        return entretienRepo.findByIdCandidat(idCandidat).isPresent();
    }

    public void validerEntretien(Integer idCandidat, String statut, String commentaire, LocalDate date) {
        Candidat c = candidatRepo.findById(idCandidat)
                .orElseThrow(() -> new RuntimeException("Candidat introuvable"));

        Optional<Entretien> entretienOpt = entretienRepo.findByIdCandidat(idCandidat);

        Entretien entretien;
        if (entretienOpt.isPresent()) {
            entretien = entretienOpt.get();
        } else {
            entretien = new Entretien();
            entretien.setIdCandidat(c.getId());
            Integer idAnnonce = c.getIdAnnoncePostule();
            Annonce annonce = annonceRepo.findById(idAnnonce.longValue())
                    .orElseThrow(() -> new RuntimeException("Annonce introuvable"));
            entretien.setSalaireNifanarahana(annonce.getSalaire());
        }

        entretien.setStatut(statut);
        entretien.setCommentaire(commentaire != null ? commentaire : "");
        entretien.setDateEntretien(date != null ? date : LocalDate.now());

        entretienRepo.save(entretien);
    }

  

    public List<Candidat> getCandidatsEntretienValide() {
    List<Entretien> entretiensValides = entretienRepo.findByStatut("Valide"); // Attention majuscule
    List<Candidat> candidats = new ArrayList<>();
    for (Entretien e : entretiensValides) {
        candidatRepo.findById(e.getIdCandidat()).ifPresent(candidats::add);
    }
    return candidats;
}

    
}
