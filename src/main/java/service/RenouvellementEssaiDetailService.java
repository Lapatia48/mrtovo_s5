package service;

import entity.RenouvellementEssaiDetail;
import repository.RenouvellementEssaiDetailRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class RenouvellementEssaiDetailService {

    @Autowired
    private RenouvellementEssaiDetailRepository repository;

    // ===== Récupérer tous les renouvellements détaillés =====
    public List<RenouvellementEssaiDetail> findAll() {
        return repository.findAll();
    }

    // ===== Récupérer par département =====
    public List<RenouvellementEssaiDetail> findByDepartement(String departement) {
        return repository.findByDepartement(departement);
    }

    // ===== Récupérer par diplôme =====
    public List<RenouvellementEssaiDetail> findByDiplome(String diplome) {
        return repository.findByDiplome(diplome);
    }

    // ===== Récupérer par période =====
    public List<RenouvellementEssaiDetail> findByPeriode(Integer periode) {
        return repository.findByPeriode(periode);
    }

    // ===== Rechercher par nom ou prénom =====
    public List<RenouvellementEssaiDetail> searchByNomOrPrenom(String searchTerm) {
        return repository.findByNomContainingIgnoreCaseOrPrenomContainingIgnoreCase(searchTerm, searchTerm);
    }

    // ===== Récupérer par salaire minimum =====
    public List<RenouvellementEssaiDetail> findBySalaireMin(Integer salaireMin) {
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
    public RenouvellementEssaiDetail findById(Integer id) {
        return repository.findById(id).orElse(null);
    }

    // ===== Récupérer par ID candidat =====
    public RenouvellementEssaiDetail findByIdCandidat(Integer idCandidat) {
        List<RenouvellementEssaiDetail> result = repository.findAll().stream()
                .filter(r -> r.getIdCandidat().equals(idCandidat))
                .collect(java.util.stream.Collectors.toList());
        return result.isEmpty() ? null : result.get(0);
    }
}