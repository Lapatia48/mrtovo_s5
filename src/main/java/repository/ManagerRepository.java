package repository;

import entity.Manager;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ManagerRepository extends JpaRepository<Manager, Integer> {
    
    Optional<Manager> findByNomAndMdp(String nom, String mdp);
}
