package repository;

import entity.Essai;
import jakarta.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Transactional
@Repository
public interface EssaiRepository extends JpaRepository<Essai, Integer> {

    // Trouver par id_candidat
    Optional<Essai> findByIdCandidat(Integer idCandidat);

    // Lister tous les essais d'un candidat
    // List<Essai> findByIdCandidat(Integer idCandidat);

    // Supprimer par id_candidat
    @Transactional
    void deleteByIdCandidat(Integer idCandidat);

    // Vérifier si un candidat est en période d'essai
    boolean existsByIdCandidat(Integer idCandidat);

    // Compter le nombre d'essais pour un candidat
    long countByIdCandidat(Integer idCandidat);
}