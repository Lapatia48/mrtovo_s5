package service;

import entity.EssaiDetail;
import repository.EssaiDetailRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class EssaiDetailService {

    @Autowired
    private EssaiDetailRepository repository;

    // ===== Récupérer tous les essais détaillés =====
    public List<EssaiDetail> findAll() {
        return repository.findAll();
    }

    // ===== Récupérer par département =====
    public List<EssaiDetail> findByDepartement(String departement) {
        return repository.findByDepartement(departement);
    }

    // ===== Récupérer par diplôme =====
    public List<EssaiDetail> findByDiplome(String diplome) {
        return repository.findByDiplome(diplome);
    }

    // ===== Récupérer par période d'essai =====
    public List<EssaiDetail> findByPeriode(Integer periode) {
        return repository.findByPeriode(periode);
    }

    // ===== Rechercher par nom ou prénom =====
    public List<EssaiDetail> searchByNomOrPrenom(String searchTerm) {
        return repository.findByNomContainingIgnoreCaseOrPrenomContainingIgnoreCase(searchTerm, searchTerm);
    }

    // ===== Récupérer par salaire minimum =====
    public List<EssaiDetail> findBySalaireMin(Integer salaireMin) {
        return repository.findBySalaireGreaterThanEqual(salaireMin);
    }

    // ===== Compter par département =====
    public long countByDepartement(String departement) {
        return repository.countByDepartement(departement);
    }

    // ===== Récupérer les départements distincts =====
    public List<String> getDistinctDepartements() {
        return repository.findDistinctDepartements();
    }

    // ===== Récupérer par ID =====
    public EssaiDetail findById(Integer id) {
        return repository.findById(id).orElse(null);
    }

    // ===== Récupérer par ID candidat =====
    public EssaiDetail findByIdCandidat(Integer idCandidat) {
        List<EssaiDetail> result = repository.findAll().stream()
                .filter(e -> e.getIdCandidat().equals(idCandidat))
                .collect(java.util.stream.Collectors.toList());
        return result.isEmpty() ? null : result.get(0);
    }
}