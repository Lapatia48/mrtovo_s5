package repository;

import entity.Candidat;

import java.util.*;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface CandidatRepository extends JpaRepository<Candidat, Integer> {

    //fonc log
    Optional<Candidat> findByMailAndPrenom(String mail, String prenom);
    Optional<Candidat> findByMail(String mail);
    Optional<Candidat> findByMailAndIdAnnoncePostule(String mail, Integer idAnnoncePostule);

}
