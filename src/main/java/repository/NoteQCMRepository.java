package repository;

import entity.NoteQCM;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface NoteQCMRepository extends JpaRepository<NoteQCM, Integer> {

    List<NoteQCM> findByIdCandidat(Integer idCandidat);
}
