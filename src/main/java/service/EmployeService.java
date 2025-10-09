package service;

import entity.Employe;
import repository.EmployeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class EmployeService {

    @Autowired
    private EmployeRepository repository;

    // ===== Sauvegarder un employé =====
    public Employe save(Employe employe) {
        return repository.save(employe);
    }

    // ===== Récupérer tous les employés =====
    public List<Employe> findAll() {
        return repository.findAll();
    }

    // ===== Récupérer un employé par ID =====
    public Optional<Employe> findById(Integer id) {
        return repository.findById(id);
    }

    // ===== Vérifier si un email existe déjà =====
    public boolean existsByMail(String mail) {
        return repository.findAll().stream()
                .anyMatch(e -> e.getMail().equalsIgnoreCase(mail));
    }

    // ===== Récupérer par id_candidat =====
    public Optional<Employe> findByIdCandidat(Integer idCandidat) {
        return repository.findAll().stream()
                .filter(e -> e.getIdCandidat() != null && e.getIdCandidat().equals(idCandidat))
                .findFirst();
    }
}