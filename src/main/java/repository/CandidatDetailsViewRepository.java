package repository;

import entity.CandidatDetailsView;



import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CandidatDetailsViewRepository extends JpaRepository<CandidatDetailsView, Integer> {

}
