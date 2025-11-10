package repository;

import entity.CongeeEmployeDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CongeeEmployeDetailsRepository extends JpaRepository<CongeeEmployeDetails, Integer> {
    List<CongeeEmployeDetails> findByIdEmploye(Integer idEmploye);
    List<CongeeEmployeDetails> findByDepartement(String departement);
    List<CongeeEmployeDetails> findByAnnee(Integer annee);
}