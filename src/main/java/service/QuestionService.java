package service;

import entity.Question;
import repository.QuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
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

    // ===== Récupérer 3 questions aléatoires d'un département =====
    public List<Question> getQuestionsByDepartement(Integer idDepartement) {
        // Récupérer toutes les questions du département
        List<Question> allQuestions = questionRepository.findByIdDepartement(idDepartement);
        
        // Mélanger aléatoirement la liste
        Collections.shuffle(allQuestions);
        
        // Retourner les 3 premières questions (ou moins si moins de 3 questions disponibles)
        int limit = Math.min(3, allQuestions.size());
        return allQuestions.subList(0, limit);
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
