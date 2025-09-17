package repository;

import entity.Departement;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;


@Repository
public interface DepartementRepository extends JpaRepository<Departement, Long> {
    
    @Query("SELECT d.libelleDepartement FROM Departement d WHERE d.id = :idDept")
    String getNameById(@Param("idDept") Long idDept);
}
