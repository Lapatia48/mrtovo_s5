package repository;

import entity.Candidat;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CandidatRepository extends JpaRepository<Candidat, Integer> {

    //fonc log
    Optional<Candidat> findByMailAndPrenom(String mail, String prenom);
}
