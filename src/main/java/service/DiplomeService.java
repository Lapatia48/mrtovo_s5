package service;

import entity.Diplome;
import repository.DiplomeRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DiplomeService {

    private final DiplomeRepository diplomeRepository;

    public DiplomeService(DiplomeRepository diplomeRepository) {
        this.diplomeRepository = diplomeRepository;
    }

    public List<Diplome> findAll() {
        return diplomeRepository.findAll();
    }

    public Diplome findById(Integer id) {
        return diplomeRepository.findById(id).orElse(null);
    }

    public Diplome save(Diplome diplome) {
        return diplomeRepository.save(diplome);
    }

    public void deleteById(Integer id) {
        diplomeRepository.deleteById(id);
    }
}
