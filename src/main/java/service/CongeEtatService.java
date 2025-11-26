package service;

import entity.CongeEtat;
import repository.CongeEtatRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CongeEtatService {

    @Autowired
    private CongeEtatRepository congeEtatRepository;

    public CongeEtat save(CongeEtat congeEtat) {
        return congeEtatRepository.save(congeEtat);
    }

    public List<CongeEtat> findByIdEmployeAndStatutEnAttente(Integer idEmploye) {
        return congeEtatRepository.findByIdEmployeAndStatutEnAttente(idEmploye);
    }
    
    public CongeEtat findById(Integer id) {
        return congeEtatRepository.findById(id).orElse(null);
    }

}