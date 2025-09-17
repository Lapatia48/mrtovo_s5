package service;

import entity.Manager;
import repository.ManagerRepository;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ManagerService {

    @Autowired
    private ManagerRepository managerRepository;

    public Optional<Manager> login(String nom, String mdp) {
        return managerRepository.findByNomAndMdp(nom, mdp);
    }

    public Manager save(Manager manager) {
        return managerRepository.save(manager);
    }

    public Manager findById(Integer id) {
        return managerRepository.findById(id).orElse(null);
    }
}
