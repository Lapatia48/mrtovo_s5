package repository;

import entity.RenouvellementEssai;
import jakarta.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Transactional
@Repository
public interface RenouvellementEssaiRepository extends JpaRepository<RenouvellementEssai, Integer> {

    // Trouver par id_candidat
    Optional<RenouvellementEssai> findByIdCandidat(Integer idCandidat);

    // Lister tous les renouvellements d'un candidat
    // List<RenouvellementEssai> findByIdCandidat(Integer idCandidat);

    // Supprimer par id_candidat
    @Transactional
    void deleteByIdCandidat(Integer idCandidat);

    // Vérifier si un candidat a un renouvellement d'essai
    boolean existsByIdCandidat(Integer idCandidat);

    // Compter le nombre de renouvellements pour un candidat
    long countByIdCandidat(Integer idCandidat);
}