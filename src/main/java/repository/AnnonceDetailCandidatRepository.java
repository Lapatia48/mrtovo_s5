package repository;

import entity.AnnonceDetailCandidat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AnnonceDetailCandidatRepository extends JpaRepository<AnnonceDetailCandidat, Integer> {
    
    Optional<AnnonceDetailCandidat> findByCandidatId(Integer candidatId);
}