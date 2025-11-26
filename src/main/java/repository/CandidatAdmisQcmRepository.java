package repository;

import entity.CandidatAdmisQcm;
import entity.CandidatAdmisQcmDetails;
import jakarta.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Transactional
@Repository
public interface CandidatAdmisQcmRepository extends JpaRepository<CandidatAdmisQcm, Integer> {

    List<CandidatAdmisQcm> findByIdCandidat(Integer idCandidat);
    @Transactional
    void deleteAllByIdCandidat(Integer idCandidat);
}