package service;

import entity.CandidatAdmisQcmDetails;
import repository.CandidatAdmisQcmDetailsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class CandidatAdmisQcmDetailsService {

    @Autowired
    private CandidatAdmisQcmDetailsRepository repository;

    // ===== Récupérer tous les candidats admis au QCM =====
    public List<CandidatAdmisQcmDetails> findAll() {
        return repository.findAll();
    }

    public Optional<CandidatAdmisQcmDetails> findByIdCandidat(Integer idCandidat) {
        return repository.findByIdCandidat(idCandidat);
    }
}