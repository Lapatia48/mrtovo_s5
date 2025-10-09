package repository;

import entity.RenouvellementEssaiDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface RenouvellementEssaiDetailRepository extends JpaRepository<RenouvellementEssaiDetail, Integer> {

    // Trouver par département
    List<RenouvellementEssaiDetail> findByDepartement(String departement);

    // Trouver par diplôme
    List<RenouvellementEssaiDetail> findByDiplome(String diplome);

    // Trouver par période
    List<RenouvellementEssaiDetail> findByPeriode(Integer periode);

    // Recherche par nom ou prénom
    List<RenouvellementEssaiDetail> findByNomContainingIgnoreCaseOrPrenomContainingIgnoreCase(String nom, String prenom);

    // Trouver par salaire minimum
    @Query("SELECT r FROM RenouvellementEssaiDetail r WHERE r.salaire >= :salaireMin")
    List<RenouvellementEssaiDetail> findBySalaireGreaterThanEqual(@Param("salaireMin") Integer salaireMin);

    // Compter par département
    long countByDepartement(String departement);

    // Récupérer les départements distincts
    @Query("SELECT DISTINCT r.departement FROM RenouvellementEssaiDetail r")
    List<String> findDistinctDepartements();
}