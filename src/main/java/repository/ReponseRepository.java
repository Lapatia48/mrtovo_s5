package repository;

import entity.Reponse;
import jakarta.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Transactional
@Repository
public interface ReponseRepository extends JpaRepository<Reponse, Integer> {

    List<Reponse> findByIdQuestion(Integer idQuestion);

    @Transactional
    @Modifying
    @Query("DELETE FROM Reponse r WHERE r.idQuestion = :questionId")
    void deleteByQuestionId(@Param("questionId") Integer questionId);
}
