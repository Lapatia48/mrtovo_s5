package service;

import entity.*;
import entity.CandidatRefuse;
import repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CandidatQCMService {

    private static final int NOTE_MIN_ADMISSION = 4;

    @Autowired
    private NoteQcmRepository noteRepo;

    @Autowired
    private CandidatAdmisQcmRepository admisRepo;

    @Autowired
    private CandidatRefuseRepository refuseRepo;

    @Autowired
    private CandidatRepository candidatRepo;

    // Traite tous les candidats et empêche les doublons
    public void traiterCandidatsQCM() {

        // Candidats admis (note >= 4)
        List<NoteQcm> notesAdmis = noteRepo.findByNoteGreaterThanEqual(NOTE_MIN_ADMISSION);
        for (NoteQcm n : notesAdmis) {
            // Vérifier si le candidat n'est pas déjà dans la table admis
            if (!admisRepo.existsByIdCandidat(n.getIdCandidat())) {
                CandidatAdmisQcm admis = new CandidatAdmisQcm();
                admis.setIdCandidat(n.getIdCandidat());
                admisRepo.save(admis);
            }
        }

        // Candidats refusés (note < 4)
        List<NoteQcm> notesRefus = noteRepo.findByNoteLessThan(NOTE_MIN_ADMISSION);
        for (NoteQcm n : notesRefus) {
            // Vérifier si le candidat n'est pas déjà dans la table refus
            if (!refuseRepo.existsByIdCandidat(n.getIdCandidat())) {
                CandidatRefuse refuse = new CandidatRefuse();
                refuse.setIdCandidat(n.getIdCandidat());
                refuse.setLibelleEtape("QCM");
                refuseRepo.save(refuse);
            }
        }
    }

    // Remplit les infos pour l'affichage
    public void enrichirInfosCandidats(List<CandidatAdmisQcm> admis, List<CandidatRefuse> refuses) {
        for (CandidatAdmisQcm a : admis) {
            candidatRepo.findById(a.getIdCandidat()).ifPresent(c -> {
                a.setNom(c.getNom());
                a.setPrenom(c.getPrenom());
                a.setMail(c.getMail());
            });
        }
        for (CandidatRefuse r : refuses) {
            candidatRepo.findById(r.getIdCandidat()).ifPresent(c -> {
                r.setNom(c.getNom());
                r.setPrenom(c.getPrenom());
                r.setMail(c.getMail());
            });
        }
    }
}
