package repository;

import entity.EmployePointage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface EmployePointageRepository extends JpaRepository<EmployePointage, Integer> {
    
    // Trouver tous les employés triés par département et nom
    List<EmployePointage> findAllByOrderByDepartementAscNomAsc();
    
    // Trouver par département
    List<EmployePointage> findByDepartementOrderByNomAsc(String departement);
    
    // Trouver par poste
    List<EmployePointage> findByPosteOrderByNomAsc(String poste);
    
    // Recherche par nom ou prénom
    @Query("SELECT e FROM EmployePointage e WHERE LOWER(e.nom) LIKE LOWER(CONCAT('%', :recherche, '%')) OR LOWER(e.prenom) LIKE LOWER(CONCAT('%', :recherche, '%'))")
    List<EmployePointage> findByNomOrPrenomContaining(String recherche);
    
    // Compter par département
    @Query("SELECT e.departement, COUNT(e) FROM EmployePointage e GROUP BY e.departement")
    List<Object[]> countByDepartement();
}