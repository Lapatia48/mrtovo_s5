package repository;

import org.springframework.data.jpa.repository.JpaRepository;
import entity.Essai;

public interface EssaiRepository extends JpaRepository<Essai, Integer> {
    boolean existsByIdCandidat(Integer idCandidat);
}
