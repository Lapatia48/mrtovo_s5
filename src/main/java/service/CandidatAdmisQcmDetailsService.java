package service;

import entity.CandidatAdmisQcmDetails;
import repository.CandidatAdmisQcmDetailsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CandidatAdmisQcmDetailsService {

    @Autowired
    private CandidatAdmisQcmDetailsRepository repository;

    // ===== Récupérer tous les candidats admis au QCM =====
    public List<CandidatAdmisQcmDetails> findAll() {
        return repository.findAll();
    }

    // ===== Récupérer par département =====
    public List<CandidatAdmisQcmDetails> findByDepartement(String departement) {
        return repository.findByDepartement(departement);
    }

    // ===== Récupérer par diplôme =====
    public List<CandidatAdmisQcmDetails> findByDiplome(String diplome) {
        return repository.findByDiplome(diplome);
    }

    // ===== Récupérer avec une note minimale =====
    public List<CandidatAdmisQcmDetails> findByNoteMin(Integer noteMin) {
        return repository.findByNoteQcmGreaterThanEqual(noteMin);
    }

    // ===== Récupérer avec note entre deux valeurs =====
    public List<CandidatAdmisQcmDetails> findByNoteBetween(Integer noteMin, Integer noteMax) {
        return repository.findByNoteQcmBetween(noteMin, noteMax);
    }

    // ===== Rechercher par nom ou prénom =====
    public List<CandidatAdmisQcmDetails> searchByNomOrPrenom(String searchTerm) {
        return repository.findByNomContainingIgnoreCaseOrPrenomContainingIgnoreCase(searchTerm, searchTerm);
    }

    // ===== Compter par département =====
    public long countByDepartement(String departement) {
        return repository.countByDepartement(departement);
    }

    // ===== Récupérer les candidats sans note QCM =====
    public List<CandidatAdmisQcmDetails> findCandidatsSansNoteQcm() {
        return repository.findCandidatsSansNoteQcm();
    }

    // ===== Récupérer triés par note décroissante =====
    public List<CandidatAdmisQcmDetails> findAllOrderByNoteDesc() {
        return repository.findAllOrderByNoteDesc();
    }

    // ===== Récupérer par ID =====
    public CandidatAdmisQcmDetails findById(Integer id) {
        return repository.findById(id).orElse(null);
    }
}