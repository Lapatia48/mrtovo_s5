package repository;

import entity.CandidatRefuseDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CandidatRefuseDetailsRepository extends JpaRepository<CandidatRefuseDetails, Integer> {

    // Trouver par libellé d'étape
    List<CandidatRefuseDetails> findByLibelleEtape(String libelleEtape);

    // Trouver par département
    List<CandidatRefuseDetails> findByDepartement(String departement);

    // Trouver par diplôme
    List<CandidatRefuseDetails> findByDiplome(String diplome);

    // Recherche par nom ou prénom
    List<CandidatRefuseDetails> findByNomContainingIgnoreCaseOrPrenomContainingIgnoreCase(String nom, String prenom);

    // Compter par étape de refus
    long countByLibelleEtape(String libelleEtape);

    // Récupérer les étapes de refus distinctes
    @Query("SELECT DISTINCT c.libelleEtape FROM CandidatRefuseDetails c")
    List<String> findDistinctLibelleEtape();
}