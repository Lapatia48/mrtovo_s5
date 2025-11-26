package service;

import entity.Contrat;
import repository.ContratRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ContratService {

    @Autowired
    private ContratRepository contratRepository;

    // Ajouter un contrat
    public Contrat save(Contrat contrat) {
        return contratRepository.save(contrat);
    }

    // Récupérer tous les contrats
    public List<Contrat> findAll() {
        return contratRepository.findAll();
    }

    // Récupérer un contrat par son ID
    public Optional<Contrat> findById(Integer id) {
        return contratRepository.findById(id);
    }

    // Récupérer un contrat par son numéro
    public Optional<Contrat> findByNumeroContrat(String numeroContrat) {
        return contratRepository.findByNumeroContrat(numeroContrat);
    }

    // Récupérer tous les contrats d'un employé
    public List<Contrat> findByIdEmploye(Integer idEmploye) {
        return contratRepository.findByIdEmploye(idEmploye);
    }

    // Récupérer les contrats actifs d'un employé
    // Dans ContratService.java
    public List<Contrat> findContratsActifsByEmploye(Integer idEmploye) {
        return contratRepository.findByIdEmployeAndStatutContrat(idEmploye, "actif");
    }

    // Vérifier si un employé a un contrat actif
    public boolean existsContratActifByEmploye(Integer idEmploye) {
        return contratRepository.existsContratActifByEmploye(idEmploye);
    }

    // Récupérer les contrats par statut
    public List<Contrat> findByStatutContrat(String statutContrat) {
        return contratRepository.findByStatutContrat(statutContrat);
    }

    // Récupérer les contrats par type
    public List<Contrat> findByTypeContrat(String typeContrat) {
        return contratRepository.findByTypeContrat(typeContrat);
    }

    // Mettre à jour un contrat
    public Contrat update(Contrat contrat) {
        return contratRepository.save(contrat);
    }

    // Supprimer un contrat
    public void delete(Integer id) {
        contratRepository.deleteById(id);
    }

    // Supprimer un contrat par son numéro
    public void deleteByNumeroContrat(String numeroContrat) {
        Optional<Contrat> contrat = contratRepository.findByNumeroContrat(numeroContrat);
        contrat.ifPresent(c -> contratRepository.delete(c));
    }
}