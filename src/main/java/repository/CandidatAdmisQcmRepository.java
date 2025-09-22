package repository;

import entity.CandidatAdmisQcm;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CandidatAdmisQcmRepository extends JpaRepository<CandidatAdmisQcm, Long> {
    // Vérifie si un candidat est déjà dans la table admis
    boolean existsByIdCandidat(Integer idCandidat);
}
