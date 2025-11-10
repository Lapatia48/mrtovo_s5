package service;

import entity.ContratEmployeView;
import repository.ContratEmployeViewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ContratEmployeViewService {

    @Autowired
    private ContratEmployeViewRepository contratEmployeViewRepository;

    // Récupérer tous les contrats avec employés
    public List<ContratEmployeView> findAll() {
        return contratEmployeViewRepository.findAllByOrderByDateCreationDesc();
    }

    // Récupérer un contrat par son ID
    public Optional<ContratEmployeView> findById(Integer id) {
        return contratEmployeViewRepository.findById(id);
    }

    // Récupérer les contrats d'un employé
    public List<ContratEmployeView> findByIdEmploye(Integer idEmploye) {
        return contratEmployeViewRepository.findByIdEmployeOrderByDateCreationDesc(idEmploye);
    }

    // Récupérer les contrats par statut
    public List<ContratEmployeView> findByStatutContrat(String statutContrat) {
        return contratEmployeViewRepository.findByStatutContratOrderByDateCreationDesc(statutContrat);
    }

    // Récupérer les contrats par type
    public List<ContratEmployeView> findByTypeContrat(String typeContrat) {
        return contratEmployeViewRepository.findByTypeContratOrderByDateCreationDesc(typeContrat);
    }

    // Recherche par nom ou prénom
    public List<ContratEmployeView> searchByNomOrPrenom(String recherche) {
        return contratEmployeViewRepository.findByNomOrPrenomContaining(recherche);
    }

    // Récupérer les contrats actifs
    public List<ContratEmployeView> findContratsActifs() {
        return contratEmployeViewRepository.findContratsActifs();
    }

    // Statistiques
    public long getTotalContrats() {
        return contratEmployeViewRepository.count();
    }

    public long getContratsActifsCount() {
        return contratEmployeViewRepository.findContratsActifs().size();
    }

    public long getContratsCDICount() {
        return contratEmployeViewRepository.findByTypeContratOrderByDateCreationDesc("CDI").size();
    }
}