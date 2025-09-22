package repository;

import entity.Candidat;
import entity.Entretien;

import java.util.*;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EntretienRepository extends JpaRepository<Entretien, Integer> {
    Optional<Entretien> findByIdCandidat(Integer idCandidat);

    List<Entretien> findByStatut(String statut);
}

