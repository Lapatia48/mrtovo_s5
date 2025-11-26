package service;

import entity.Rh;
import repository.RhRepository;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RhService {

    @Autowired
    private RhRepository rhRepository;

    public Optional<Rh> login(String nom, String mdp) {
        return rhRepository.findByNomAndMdp(nom, mdp);
    }

    public Rh save(Rh rh) {
        return rhRepository.save(rh);
    }

    public Rh findById(Integer id) {
        return rhRepository.findById(id).orElse(null);
    }
}
