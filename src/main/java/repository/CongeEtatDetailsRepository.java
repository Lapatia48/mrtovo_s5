package repository;

import entity.CongeEtatDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CongeEtatDetailsRepository extends JpaRepository<CongeEtatDetails, Integer> {
    List<CongeEtatDetails> findByIdEmploye(Integer idEmploye);
    List<CongeEtatDetails> findByStatut(String statut);
    List<CongeEtatDetails> findByDepartement(String departement);

    @Query(value = "SELECT * FROM conge_etat_details WHERE statut = 'en_attente'", nativeQuery = true)
    List<CongeEtatDetails> findAllEnAttente();

    @Query(value = "SELECT * FROM conge_etat_details WHERE statut = 'approuve'", nativeQuery = true)
    List<CongeEtatDetails> findAllEnCoursGeneral();

    @Query(value = "SELECT * FROM conge_etat_details WHERE statut = 'refuse'", nativeQuery = true)
    List<CongeEtatDetails> findAllRefuses();

    @Query(value = "SELECT * FROM conge_etat_details", nativeQuery = true)
    List<CongeEtatDetails> findAll();
}