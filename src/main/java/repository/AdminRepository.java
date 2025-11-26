package repository;

import entity.Admin;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AdminRepository extends JpaRepository<Admin, Integer> {
    
    Optional<Admin> findByNomAndMdp(String nom, String mdp);
}
