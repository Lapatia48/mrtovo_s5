package service;

import entity.Admin;
import repository.AdminRepository;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService {

    @Autowired
    private AdminRepository adminRepository;

    public Optional<Admin> login(String nom, String mdp) {
        return adminRepository.findByNomAndMdp(nom, mdp);
    }

    public Admin save(Admin admin) {
        return adminRepository.save(admin);
    }

    public Admin findById(Integer id) {
        return adminRepository.findById(id).orElse(null);
    }
}
