package repository;

import entity.CandidatRefuse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CandidatRefuseRepository extends JpaRepository<CandidatRefuse, Integer> {

    // Lister tous les refus d’un candidat donné
    List<CandidatRefuse> findByIdCandidat(Integer idCandidat);

    // Supprimer tous les refus d’un candidat donné
    void deleteByIdCandidat(Integer idCandidat);
}
