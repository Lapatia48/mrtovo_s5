package service;

import entity.QuestionsReponsesView;
import repository.QuestionsReponsesViewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class QuestionsReponsesViewService {

    @Autowired
    private QuestionsReponsesViewRepository questionsReponsesViewRepository;

    public List<QuestionsReponsesView> findByIdDepartement(Integer idDepartement) {
        return questionsReponsesViewRepository.findByIdDepartement(idDepartement);
    }

    public List<QuestionsReponsesView> findByQuestionId(Integer questionId) {
        return questionsReponsesViewRepository.findByQuestionId(questionId);
    }

    public List<QuestionsReponsesView> findReponsesCorrectesByDepartement(Integer idDepartement) {
        return questionsReponsesViewRepository.findReponsesCorrectesByDepartement(idDepartement);
    }

    public List<Object[]> findQuestionsByDepartement(Integer idDepartement) {
        return questionsReponsesViewRepository.findQuestionsByDepartement(idDepartement);
    }

    public List<QuestionsReponsesView> findAll() {
        return questionsReponsesViewRepository.findAll();
    }

    public List<QuestionsReponsesView> findReponsesCorrectes() {
        return questionsReponsesViewRepository.findByEstVraieTrue();
    }
}