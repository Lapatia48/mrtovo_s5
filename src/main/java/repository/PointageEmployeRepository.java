package repository;

import entity.PointageEmploye;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface PointageEmployeRepository extends JpaRepository<PointageEmploye, Integer> {
    
    List<PointageEmploye> findByIdEmploye(Integer idEmploye);
    
    List<PointageEmploye> findByTypeEvenement(String typeEvenement);
    
    List<PointageEmploye> findByDateEvenementBetween(java.time.LocalDate debut, java.time.LocalDate fin);
}