package service;

import entity.Reponse;
import jakarta.transaction.Transactional;
import repository.ReponseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Transactional
@Service
public class ReponseService {

    @Autowired
    private ReponseRepository reponseRepository;

    public List<Reponse> getAllReponses() {
        return reponseRepository.findAll(); 
    }
   
    public Optional<Reponse> getReponseById(Integer id) { 
        return reponseRepository.findById(id); 
    }
   
    public List<Reponse> getReponsesByQuestion(Integer idQuestion) {
        return reponseRepository.findByIdQuestion(idQuestion); 
        }
    
    public Reponse saveReponse(Reponse reponse) { 
        return reponseRepository.save(reponse);
    }
    
    public void deleteReponse(Integer id) { 
        reponseRepository.deleteById(id); 
    }

    @Transactional
    public void deleteByQuestionId(Integer questionId) {
        reponseRepository.deleteByQuestionId(questionId);
    }
}
