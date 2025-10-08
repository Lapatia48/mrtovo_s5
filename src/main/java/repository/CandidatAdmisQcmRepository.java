package repository;

import entity.CandidatAdmisQcm;
import entity.CandidatAdmisQcmDetails;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface CandidatAdmisQcmRepository extends JpaRepository<CandidatAdmisQcm, Integer> {

    // Vérifier si un candidat est déjà admis au QCM
    // Optional<CandidatAdmisQcm> findByIdCandidat(Integer idCandidat);

    // Lister tous les admis d'un candidat donné
    // List<CandidatAdmisQcm> findByIdCandidat(Integer idCandidat);

    // Supprimer un admis par idCandidat
    void deleteByIdCandidat(Integer idCandidat);

    // Compter le nombre d'admis pour un candidat
    long countByIdCandidat(Integer idCandidat);

}