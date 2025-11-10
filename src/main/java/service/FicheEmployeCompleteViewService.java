package service;

import entity.FicheEmployeCompleteView;
import repository.FicheEmployeCompleteViewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class FicheEmployeCompleteViewService {

    @Autowired
    private FicheEmployeCompleteViewRepository ficheEmployeCompleteViewRepository;

    // Récupérer toutes les fiches
    public List<FicheEmployeCompleteView> findAll() {
        return ficheEmployeCompleteViewRepository.findAllByOrderByNomAsc();
    }

    // Récupérer une fiche par ID employé
    public Optional<FicheEmployeCompleteView> findById(Integer id) {
        return ficheEmployeCompleteViewRepository.findById(id);
    }

    // Recherche par nom ou prénom
    public List<FicheEmployeCompleteView> searchByNomOrPrenom(String recherche) {
        return ficheEmployeCompleteViewRepository.findByNomOrPrenomContaining(recherche);
    }

    // Récupérer par département
    public List<FicheEmployeCompleteView> findByDepartement(String departement) {
        return ficheEmployeCompleteViewRepository.findByDepartementOrderByNomAsc(departement);
    }

    // Récupérer par statut
    public List<FicheEmployeCompleteView> findByStatut(String statut) {
        return ficheEmployeCompleteViewRepository.findByStatutOrderByNomAsc(statut);
    }

    // Statistiques
    public long getTotalEmployes() {
        return ficheEmployeCompleteViewRepository.count();
    }

    public long getEmployesActifs() {
        return ficheEmployeCompleteViewRepository.findByStatutOrderByNomAsc("actif").size();
    }
}