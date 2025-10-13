package repository;

import entity.Question;
import jakarta.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Transactional
@Repository
public interface QuestionRepository extends JpaRepository<Question, Integer> {

    // Récupérer toutes les questions d'un département
    List<Question> findByIdDepartement(Integer idDepartement);
}
