package repository;

import entity.Contrat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ContratRepository extends JpaRepository<Contrat, Integer> {

    // Trouver un contrat par numéro
    Optional<Contrat> findByNumeroContrat(String numeroContrat);

    // Trouver tous les contrats d'un employé
    List<Contrat> findByIdEmploye(Integer idEmploye);

    // Trouver les contrats actifs d'un employé
    @Query("SELECT c FROM Contrat c WHERE c.idEmploye = :idEmploye AND c.statutContrat = 'actif'")
    List<Contrat> findContratsActifsByEmploye(@Param("idEmploye") Integer idEmploye);

    // Vérifier si un employé a déjà un contrat actif
    @Query("SELECT COUNT(c) > 0 FROM Contrat c WHERE c.idEmploye = :idEmploye AND c.statutContrat = 'actif'")
    boolean existsContratActifByEmploye(@Param("idEmploye") Integer idEmploye);

    // Trouver les contrats par statut
    List<Contrat> findByStatutContrat(String statutContrat);

    // Trouver les contrats par type
    List<Contrat> findByTypeContrat(String typeContrat);
    
 // AJOUTEZ CETTE MÉTHODE
    List<Contrat> findByIdEmployeAndStatutContrat(Integer idEmploye, String statutContrat);

    // Effectif par type de contrat
    @Query("SELECT c.typeContrat, COUNT(c) FROM Contrat c WHERE c.statutContrat = 'actif' GROUP BY c.typeContrat")
    List<Object[]> countEmployesByTypeContrat();
}