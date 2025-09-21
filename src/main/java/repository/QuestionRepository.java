package repository;

import entity.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface QuestionRepository extends JpaRepository<Question, Integer> {

    // Récupérer toutes les questions d'un département
    List<Question> findByIdDepartement(Integer idDepartement);
}
