package repository;

import entity.Employe;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface EmployeRepository extends JpaRepository<Employe, Integer> {
    // 1. Effectif par département
    @Query("SELECT e.departement, COUNT(e) FROM Employe e WHERE e.statut = 'actif' GROUP BY e.departement")
    List<Object[]> countEmployesByDepartement();
    
    // 2. Effectif par tranche d'âge
    @Query(value = """
        SELECT 
            CASE 
                WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, e.date_naissance)) < 25 THEN 'Moins de 25'
                WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, e.date_naissance)) BETWEEN 25 AND 35 THEN '25-35'
                WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, e.date_naissance)) BETWEEN 36 AND 45 THEN '36-45'
                ELSE 'Plus de 45'
            END as tranche_age,
            COUNT(*) as effectif
        FROM employe e
        WHERE e.statut = 'actif'
        GROUP BY tranche_age
        ORDER BY tranche_age
        """, nativeQuery = true)
    List<Object[]> countEmployesByTrancheAge();
    
    // 3. Ancienneté moyenne - Version simplifiée
    @Query(value = """
        SELECT CAST(AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, e.date_embauche))) AS DOUBLE PRECISION) 
        FROM employe e 
        WHERE e.statut = 'actif'
        """, nativeQuery = true)
    Double findAncienneteMoyenne();

    // 4. Méthode alternative pour l'âge utilisant la méthode getAge() de l'entité
    @Query("SELECT e FROM Employe e WHERE e.statut = 'actif'")
    List<Employe> findAllActifs();

    @Query("SELECT COUNT(e) FROM Employe e WHERE e.statut = 'actif'")
    Long countEmployesActifs();
}