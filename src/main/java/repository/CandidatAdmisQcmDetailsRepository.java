package repository;

import entity.CandidatAdmisQcmDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CandidatAdmisQcmDetailsRepository extends JpaRepository<CandidatAdmisQcmDetails, Integer> {

    // ===== Trouver par département =====
    List<CandidatAdmisQcmDetails> findByDepartement(String departement);

    // ===== Trouver par diplôme =====
    List<CandidatAdmisQcmDetails> findByDiplome(String diplome);

    // ===== Trouver par note QCM supérieure ou égale =====
    List<CandidatAdmisQcmDetails> findByNoteQcmGreaterThanEqual(Integer noteMin);

    // ===== Trouver par note QCM entre deux valeurs =====
    List<CandidatAdmisQcmDetails> findByNoteQcmBetween(Integer noteMin, Integer noteMax);

    // ===== Recherche par nom ou prénom =====
    List<CandidatAdmisQcmDetails> findByNomContainingIgnoreCaseOrPrenomContainingIgnoreCase(String nom, String prenom);

    // ===== Compter par département =====
    long countByDepartement(String departement);

    // ===== Requête personnalisée pour les candidats sans note QCM =====
    @Query("SELECT c FROM CandidatAdmisQcmDetails c WHERE c.noteQcm IS NULL")
    List<CandidatAdmisQcmDetails> findCandidatsSansNoteQcm();

    // ===== Requête personnalisée pour trier par note décroissante =====
    @Query("SELECT c FROM CandidatAdmisQcmDetails c WHERE c.noteQcm IS NOT NULL ORDER BY c.noteQcm DESC")
    List<CandidatAdmisQcmDetails> findAllOrderByNoteDesc();
}