package repository;

import entity.ContratEmployeView;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ContratEmployeViewRepository extends JpaRepository<ContratEmployeView, Integer> {

    // Tous les contrats avec employés (déjà triés par la vue)
    List<ContratEmployeView> findAllByOrderByDateCreationDesc();

    // Contrats d'un employé spécifique
    List<ContratEmployeView> findByIdEmployeOrderByDateCreationDesc(Integer idEmploye);

    // Contrats par statut
    List<ContratEmployeView> findByStatutContratOrderByDateCreationDesc(String statutContrat);

    // Contrats par type
    List<ContratEmployeView> findByTypeContratOrderByDateCreationDesc(String typeContrat);

    // Recherche par nom ou prénom d'employé
    @Query("SELECT c FROM ContratEmployeView c WHERE LOWER(c.nom) LIKE LOWER(CONCAT('%', :recherche, '%')) OR LOWER(c.prenom) LIKE LOWER(CONCAT('%', :recherche, '%'))")
    List<ContratEmployeView> findByNomOrPrenomContaining(@Param("recherche") String recherche);

    // Contrats actifs
    @Query("SELECT c FROM ContratEmployeView c WHERE c.statutContrat = 'actif' ORDER BY c.dateCreation DESC")
    List<ContratEmployeView> findContratsActifs();
}