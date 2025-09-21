package repository;

import entity.Reponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ReponseRepository extends JpaRepository<Reponse, Integer> {

    List<Reponse> findByIdQuestion(Integer idQuestion);
}
