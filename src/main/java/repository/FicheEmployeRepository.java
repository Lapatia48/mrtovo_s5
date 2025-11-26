package repository;

import entity.FicheEmploye;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface FicheEmployeRepository extends JpaRepository<FicheEmploye, Integer> {
    Optional<FicheEmploye> findByIdEmploye(Integer idEmploye);
    boolean existsByIdEmploye(Integer idEmploye);
}