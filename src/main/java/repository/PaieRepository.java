package repository;

import entity.Paie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface PaieRepository extends JpaRepository<Paie, Integer> {
    List<Paie> findByIdEmploye(Integer idEmploye);
    List<Paie> findByIdEmployeOrderByDatePaieDesc(Integer idEmploye);
}