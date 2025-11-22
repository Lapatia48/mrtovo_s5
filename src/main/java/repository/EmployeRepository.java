package repository;

import java.util.List;

import entity.Employe;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface EmployeRepository extends JpaRepository<Employe, Integer> {
    // Méthodes de base fournies par JpaRepository
    // save(), findAll(), findById(), deleteById(), etc.

    @Query("SELECT YEAR(e.dateNaissance), COUNT(e) " +
       "FROM Employe e GROUP BY YEAR(e.dateNaissance)")
    List<Object[]> countByBirthYear();

    @Query("SELECT e.departement, COUNT(e) FROM Employe e GROUP BY e.departement")
    List<Object[]> countByDepartement();
    
}