package repository;

import entity.VraiReponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface VraiReponseRepository extends JpaRepository<VraiReponse, Integer> {

    // List<VraiReponse> findByIdQuestion(Integer idQuestion);
    VraiReponse findByIdQuestion(Integer idQuestion);

}
