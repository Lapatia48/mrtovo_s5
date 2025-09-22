package repository;

import entity.NoteQcm;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NoteQcmRepository extends JpaRepository<NoteQcm, Long> {
    List<NoteQcm> findByNoteGreaterThanEqual(Integer noteMin);
    List<NoteQcm> findByNoteLessThan(Integer noteMax);
}
