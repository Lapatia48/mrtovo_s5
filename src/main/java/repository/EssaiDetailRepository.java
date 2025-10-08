package repository;

import entity.EssaiDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface EssaiDetailRepository extends JpaRepository<EssaiDetail, Integer> {

    // Trouver par département
    List<EssaiDetail> findByDepartement(String departement);

    // Trouver par diplôme
    List<EssaiDetail> findByDiplome(String diplome);

    // Trouver par période d'essai
    List<EssaiDetail> findByPeriode(Integer periode);

    // Recherche par nom ou prénom
    List<EssaiDetail> findByNomContainingIgnoreCaseOrPrenomContainingIgnoreCase(String nom, String prenom);

    // Trouver par salaire minimum
    @Query("SELECT e FROM EssaiDetail e WHERE e.salaire >= :salaireMin")
    List<EssaiDetail> findBySalaireGreaterThanEqual(@Param("salaireMin") Integer salaireMin);

    // Compter par département
    long countByDepartement(String departement);

    // Récupérer les départements distincts
    @Query("SELECT DISTINCT e.departement FROM EssaiDetail e")
    List<String> findDistinctDepartements();
}