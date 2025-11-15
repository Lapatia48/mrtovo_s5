package repository;

import entity.VueSoldeConges;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface VueSoldeCongesRepository extends JpaRepository<VueSoldeConges, Integer> {
    
    // Trouver tous les soldes triés par département et nom
    List<VueSoldeConges> findAllByOrderByDepartementAscNomAsc();
    
    // Trouver par département
    List<VueSoldeConges> findByDepartementOrderByNomAsc(String departement);
    
    // Trouver par année
    List<VueSoldeConges> findByAnneeOrderByDepartementAscNomAsc(Integer annee);
    
    // Trouver par employé
    VueSoldeConges findByEmployeId(Integer employeId);
    
    // Trouver les soldes négatifs
    @Query("SELECT v FROM VueSoldeConges v WHERE v.soldeTotal < 0 ORDER BY v.soldeTotal ASC")
    List<VueSoldeConges> findSoldesNegatifs();
    
    // Trouver par année et département
    @Query("SELECT v FROM VueSoldeConges v WHERE v.annee = :annee AND v.departement = :departement ORDER BY v.nom")
    List<VueSoldeConges> findByAnneeAndDepartement(Integer annee, String departement);
    
    // Statistiques globales
    @Query("SELECT COUNT(v), AVG(v.soldeTotal), MIN(v.soldeTotal), MAX(v.soldeTotal) FROM VueSoldeConges v")
    Object[] getStatistiquesGlobales();
}