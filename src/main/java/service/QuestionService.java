package service;

import entity.Question;
import jakarta.transaction.Transactional;
import repository.QuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Transactional
@Service
public class QuestionService {

    @Autowired
    private QuestionRepository questionRepository;

    public List<Question> getAllQuestions() {
        return questionRepository.findAll();
    }

    public Optional<Question> getQuestionById(Integer id) {
        return questionRepository.findById(id);
    }

    public Question findById(Integer id) {
        return questionRepository.findById(id).orElse(null);
}

    public List<Question> getQuestionsByDepartement(Integer idDepartement) {
        return questionRepository.findByIdDepartement(idDepartement);
        
    }

    public Question saveQuestion(Question question) {
        return questionRepository.save(question);
    }

    @Transactional
    public void deleteQuestion(Integer id) {
        questionRepository.deleteById(id);
    }
}
