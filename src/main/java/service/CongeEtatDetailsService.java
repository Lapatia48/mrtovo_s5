package service;

import entity.CongeEtatDetails;
import repository.CongeEtatDetailsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CongeEtatDetailsService {

    @Autowired
    private CongeEtatDetailsRepository congeEtatDetailsRepository;

    public List<CongeEtatDetails> findAllEnAttente() {
        return congeEtatDetailsRepository.findAllEnAttente();
    }

    public List<CongeEtatDetails> findAllEnCoursGeneral() {
        return congeEtatDetailsRepository.findAllEnCoursGeneral();
    }

    public List<CongeEtatDetails> findAllRefuses() {
        return congeEtatDetailsRepository.findAllRefuses();
    }

    public List<CongeEtatDetails> findAll() {
        return congeEtatDetailsRepository.findAll();
    }
}