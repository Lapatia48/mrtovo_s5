package service;

import entity.CandidatAdmisQcm;
import entity.CandidatAdmisQcmDetails;
import repository.CandidatAdmisQcmRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CandidatAdmisQcmService {

    @Autowired
    private CandidatAdmisQcmRepository repository;

    // ===== Ajouter un candidat admis au QCM =====
    public CandidatAdmisQcm addAdmis(Integer idCandidat) {
        
        CandidatAdmisQcm admis = new CandidatAdmisQcm(idCandidat);
        return repository.save(admis);
    }

    // ===== Lister tous les admis =====
    public List<CandidatAdmisQcm> getAllAdmis() {
        return repository.findAll();
    }

    // ===== Supprimer une admission par id =====
    public void deleteAdmis(Integer id) {
        repository.deleteById(id);
    }

    // ===== Supprimer l'admission d'un candidat =====
    public void deleteAdmisByCandidat(Integer idCandidat) {
        repository.deleteByIdCandidat(idCandidat);
    }

    // ===== Compter les admissions d'un candidat =====
    public long countAdmisByCandidat(Integer idCandidat) {
        return repository.countByIdCandidat(idCandidat);
    }


}