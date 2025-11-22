package repository;

import entity.Congee;
import jakarta.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Transactional
@Repository
public interface CongeeRepository extends JpaRepository<Congee, Integer> {
    List<Congee> findByIdEmploye(Integer idEmploye);
    Congee findByIdEmployeAndAnnee(Integer idEmploye, Integer annee);

    @Transactional
    @Modifying
    @Query(value = "UPDATE congee SET quota = quota - :duree WHERE id_employe = :idEmploye AND annee = EXTRACT(YEAR FROM CURRENT_DATE)", nativeQuery = true)
    void updateQuota(@Param("idEmploye") Integer idEmploye, @Param("duree") Integer duree);

    // conge restant par employe
    @Query("SELECT c.nom, c.prenom, c.soldeRestant FROM CongeeEmployeDetails c")
    List<Object[]> getRemainingLeavePerEmployee();
}