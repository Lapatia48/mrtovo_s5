package service;

import entity.Question;
import repository.QuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class QuestionService {

    @Autowired
    private QuestionRepository questionRepository;

    // ===== Récupérer toutes les questions =====
    public List<Question> getAllQuestions() {
        return questionRepository.findAll();
    }

    // ===== Récupérer une question par ID =====
    public Optional<Question> getQuestionById(Integer id) {
        return questionRepository.findById(id);
    }

    // ===== Récupérer toutes les questions d'un département =====
    public List<Question> getQuestionsByDepartement(Integer idDepartement) {
        return questionRepository.findByIdDepartement(idDepartement);
    }

    // ===== Ajouter ou mettre à jour une question =====
    public Question saveQuestion(Question question) {
        return questionRepository.save(question);
    }

    // ===== Supprimer une question =====
    public void deleteQuestion(Integer id) {
        questionRepository.deleteById(id);
    }
}
