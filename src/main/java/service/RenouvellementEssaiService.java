package service;

import entity.RenouvellementEssai;
import repository.RenouvellementEssaiRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class RenouvellementEssaiService {

    @Autowired
    private RenouvellementEssaiRepository repository;

    // ===== Ajouter un renouvellement d'essai =====
    public RenouvellementEssai addRenouvellement(Integer idCandidat, Integer salaire, Integer periode) {
        // Vérifier si le candidat n'a pas déjà un renouvellement
        Optional<RenouvellementEssai> existing = repository.findByIdCandidat(idCandidat);
        if (existing.isPresent()) {
            return existing.get(); // Retourne l'existant si déjà présent
        }
        
        RenouvellementEssai renouvellement = new RenouvellementEssai(idCandidat, salaire, periode);
        return repository.save(renouvellement);
    }

    // ===== Récupérer tous les renouvellements =====
    public List<RenouvellementEssai> getAllRenouvellements() {
        return repository.findAll();
    }

    // ===== Vérifier si un candidat a un renouvellement =====
    public boolean isCandidatRenouvele(Integer idCandidat) {
        return repository.existsByIdCandidat(idCandidat);
    }

    // ===== Récupérer le renouvellement d'un candidat =====
    public Optional<RenouvellementEssai> getRenouvellementByCandidat(Integer idCandidat) {
        return repository.findByIdCandidat(idCandidat);
    }

    // ===== Mettre à jour un renouvellement =====
    public RenouvellementEssai updateRenouvellement(Integer id, Integer salaire, Integer periode) {
        Optional<RenouvellementEssai> renouvellementOpt = repository.findById(id);
        if (renouvellementOpt.isPresent()) {
            RenouvellementEssai renouvellement = renouvellementOpt.get();
            renouvellement.setSalaire(salaire);
            renouvellement.setPeriode(periode);
            return repository.save(renouvellement);
        }
        return null;
    }

    // ===== Supprimer un renouvellement par id =====
    public void deleteRenouvellement(Integer id) {
        repository.deleteById(id);
    }

    // ===== Supprimer le renouvellement d'un candidat =====
    public void deleteRenouvellementByCandidat(Integer idCandidat) {
        repository.deleteByIdCandidat(idCandidat);
    }

    // ===== Compter les renouvellements d'un candidat =====
    public long countRenouvellementsByCandidat(Integer idCandidat) {
        return repository.countByIdCandidat(idCandidat);
    }
}