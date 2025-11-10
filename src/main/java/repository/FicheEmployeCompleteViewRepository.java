package repository;

import entity.FicheEmployeCompleteView;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface FicheEmployeCompleteViewRepository extends JpaRepository<FicheEmployeCompleteView, Integer> {

    // Trouver par ID employé
    Optional<FicheEmployeCompleteView> findById(Integer id);

    // Trouver tous triés par nom
    List<FicheEmployeCompleteView> findAllByOrderByNomAsc();

    // Recherche par nom ou prénom
    @Query("SELECT f FROM FicheEmployeCompleteView f WHERE LOWER(f.nom) LIKE LOWER(CONCAT('%', :recherche, '%')) OR LOWER(f.prenom) LIKE LOWER(CONCAT('%', :recherche, '%'))")
    List<FicheEmployeCompleteView> findByNomOrPrenomContaining(@Param("recherche") String recherche);

    // Trouver par département
    List<FicheEmployeCompleteView> findByDepartementOrderByNomAsc(String departement);

    // Trouver par statut
    List<FicheEmployeCompleteView> findByStatutOrderByNomAsc(String statut);
}