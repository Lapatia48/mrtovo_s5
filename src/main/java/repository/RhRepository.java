package repository;

import entity.Rh;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RhRepository extends JpaRepository<Rh, Integer> {
    
    Optional<Rh> findByNomAndMdp(String nom, String mdp);
}
