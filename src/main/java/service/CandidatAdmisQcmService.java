package service;

import entity.CandidatAdmisQcm;
import entity.CandidatAdmisQcmDetails;
import jakarta.transaction.Transactional;
import repository.CandidatAdmisQcmRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Transactional
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

    // ===== Supprimer l'admission d'un candidat =====
    @Transactional
    public void deleteAdmisByCandidat(Integer idCandidat) {
        repository.deleteAllByIdCandidat(idCandidat);
    }


}