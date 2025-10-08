package service;

import entity.Essai;
import repository.EssaiRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class EssaiService {

    @Autowired
    private EssaiRepository repository;

    // ===== Ajouter un essai =====
    public Essai addEssai(Integer idCandidat, Integer salaire, Integer periode) {
        // Vérifier si le candidat n'est pas déjà en essai
        Optional<Essai> existing = repository.findByIdCandidat(idCandidat);
        if (existing.isPresent()) {
            return existing.get(); // Retourne l'existant si déjà présent
        }
        
        Essai essai = new Essai(idCandidat, salaire, periode);
        return repository.save(essai);
    }

    // ===== Récupérer tous les essais =====
    public List<Essai> getAllEssais() {
        return repository.findAll();
    }

    // ===== Vérifier si un candidat est en essai =====
    public boolean isCandidatEnEssai(Integer idCandidat) {
        return repository.existsByIdCandidat(idCandidat);
    }

    // ===== Récupérer l'essai d'un candidat =====
    public Optional<Essai> getEssaiByCandidat(Integer idCandidat) {
        return repository.findByIdCandidat(idCandidat);
    }

    // ===== Mettre à jour un essai =====
    public Essai updateEssai(Integer id, Integer salaire, Integer periode) {
        Optional<Essai> essaiOpt = repository.findById(id);
        if (essaiOpt.isPresent()) {
            Essai essai = essaiOpt.get();
            essai.setSalaire(salaire);
            essai.setPeriode(periode);
            return repository.save(essai);
        }
        return null;
    }

    // ===== Supprimer un essai par id =====
    public void deleteEssai(Integer id) {
        repository.deleteById(id);
    }

    // ===== Supprimer l'essai d'un candidat =====
    public void deleteEssaiByCandidat(Integer idCandidat) {
        repository.deleteByIdCandidat(idCandidat);
    }

    // ===== Compter les essais d'un candidat =====
    public long countEssaisByCandidat(Integer idCandidat) {
        return repository.countByIdCandidat(idCandidat);
    }
}