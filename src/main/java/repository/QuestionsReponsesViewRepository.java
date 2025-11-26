package repository;

import entity.QuestionsReponsesView;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuestionsReponsesViewRepository extends JpaRepository<QuestionsReponsesView, Long> {
    
    List<QuestionsReponsesView> findByIdDepartement(Integer idDepartement);
    
    List<QuestionsReponsesView> findByQuestionId(Integer questionId);
    
    @Query("SELECT q FROM QuestionsReponsesView q WHERE q.idDepartement = :idDepartement AND q.estVraie = true")
    List<QuestionsReponsesView> findReponsesCorrectesByDepartement(@Param("idDepartement") Integer idDepartement);
    
    @Query("SELECT DISTINCT q.questionId, q.question FROM QuestionsReponsesView q WHERE q.idDepartement = :idDepartement")
    List<Object[]> findQuestionsByDepartement(@Param("idDepartement") Integer idDepartement);
    
    List<QuestionsReponsesView> findByEstVraieTrue();
}