package service;

import entity.Paie;
import repository.PaieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class PaieService {

    @Autowired
    private PaieRepository paieRepository;

    public Paie save(Paie paie) {
        return paieRepository.save(paie);
    }

    public List<Paie> findByIdEmploye(Integer idEmploye) {
        return paieRepository.findByIdEmploye(idEmploye);
    }

    public Paie findById(Integer id) {
        return paieRepository.findById(id).orElse(null);
    }
}