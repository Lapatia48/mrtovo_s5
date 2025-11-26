package service;

import entity.Contrat;
import entity.Employe;
import repository.EmployeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class EmployeService {

    @Autowired
    private EmployeRepository repository;

    @Autowired
    private ContratService contratService;

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

    // ITO MODIFIER


    // CORRECTION : Méthode pour trouver les employés sans contrat
    public List<Employe> findEmployesSansContrat() {
        List<Employe> tousLesEmployes = repository.findAll();
        return tousLesEmployes.stream()
                .filter(employe -> !contratService.existsContratActifByEmploye(employe.getId()))
                .collect(Collectors.toList());
    }

    // Si vous avez besoin d'une version avec le repository directement :
    public List<Employe> findEmployesSansContratV2() {
        List<Employe> tousLesEmployes = repository.findAll();
        return tousLesEmployes.stream()
                .filter(employe -> {
                    List<Contrat> contratsActifs = contratService.findContratsActifsByEmploye(employe.getId());
                    return contratsActifs.isEmpty();
                })
                .collect(Collectors.toList());
    }

}