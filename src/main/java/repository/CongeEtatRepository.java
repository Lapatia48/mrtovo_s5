package repository;

import entity.CongeEtat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CongeEtatRepository extends JpaRepository<CongeEtat, Integer> {
    List<CongeEtat> findByIdEmploye(Integer idEmploye);
    List<CongeEtat> findByStatut(String statut);
    
    @Query("SELECT SUM(ce.duree) FROM CongeEtat ce WHERE ce.idEmploye = :idEmploye AND YEAR(ce.dateDebut) = :annee AND ce.statut = :statut")
    Integer sumDureeByEmployeAndAnneeAndStatut(@Param("idEmploye") Integer idEmploye, 
                                            @Param("annee") Integer annee, 
                                            @Param("statut") String statut);

    @Query(value = "SELECT * FROM conge_etat WHERE id_employe = :idEmploye AND statut = 'en_attente'", nativeQuery = true)
    List<CongeEtat> findByIdEmployeAndStatutEnAttente(@Param("idEmploye") Integer idEmploye);
}