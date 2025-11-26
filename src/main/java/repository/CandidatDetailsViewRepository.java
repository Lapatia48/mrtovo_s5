package repository;

import entity.CandidatDetailsView;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CandidatDetailsViewRepository extends JpaRepository<CandidatDetailsView, Integer> {

    Optional<CandidatDetailsView> findById(Integer id);
}
