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

     // Récupération des candidats avec diplôme et département
    @Query("SELECT c.id, c.nom, c.prenom, c.mail, c.adresse, c.dateNaissance, c.renseignement, " +
           "c.anneeExperience, c.datePostule, d.nomDiplome, dep.libelleDepartement " +
           "FROM Candidat c " +
           "JOIN Diplome d ON c.idDiplome = d.id " +
           "JOIN Departement dep ON c.idDepartement = dep.id " +
           "ORDER BY c.nom ASC")
    List<Object[]> findAllCandidatsWithDetails();
}
