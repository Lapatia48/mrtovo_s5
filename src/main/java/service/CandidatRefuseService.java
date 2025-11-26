package service;

import entity.CandidatRefuse;
import repository.CandidatRefuseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CandidatRefuseService {

    @Autowired
    private CandidatRefuseRepository repository;

    // Ajouter un refus
    public CandidatRefuse addRefus(Integer idCandidat, String libelleEtape) {
        CandidatRefuse refus = new CandidatRefuse(idCandidat, libelleEtape);
        return repository.save(refus);
    }

    // Lister tous les refus
    public List<CandidatRefuse> getAllRefus() {
        return repository.findAll();
    }

    // Lister les refus d’un candidat
    public List<CandidatRefuse> getRefusByCandidat(Integer idCandidat) {
        return repository.findByIdCandidat(idCandidat);
    }

    // Supprimer un refus par id
    public void deleteRefus(Integer id) {
        repository.deleteById(id);
    }

    // Supprimer tous les refus d’un candidat
    public void deleteRefusByCandidat(Integer idCandidat) {
        repository.deleteByIdCandidat(idCandidat);
    }
}
