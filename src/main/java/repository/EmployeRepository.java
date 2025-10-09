package repository;

import entity.Employe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EmployeRepository extends JpaRepository<Employe, Integer> {
    // Méthodes de base fournies par JpaRepository
    // save(), findAll(), findById(), deleteById(), etc.
}