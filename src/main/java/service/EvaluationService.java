package service;

import entity.Evaluation;
import entity.Employe;
import repository.EvaluationRepository;
import repository.EmployeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class EvaluationService {

    @Autowired
    private EvaluationRepository evaluationRepository;

    @Autowired
    private EmployeRepository employeRepository;

    // ===== Enregistrer une évaluation =====
    public void enregistrerEvaluation(Long idEmploye, String mois, int annee, int note) {
        Employe employe = employeRepository.findById(idEmploye.intValue()).orElse(null);
        if (employe != null)  {
            List<Evaluation> existantes = evaluationRepository.findByEmployeIdAndMoisAndAnnee(idEmploye, mois, annee);
            if (existantes.isEmpty()) {
                Evaluation evaluation = new Evaluation();
                evaluation.setEmploye(employe);
                evaluation.setMois(mois);
                evaluation.setAnnee(annee);
                evaluation.setNote(note);
                evaluationRepository.save(evaluation);
            } else {
                System.out.println("⚠️ Évaluation déjà existante pour cet employé ce mois-là.");
            }
        }
    }

    public List<Evaluation> getToutesLesEvaluations() {
        return evaluationRepository.findAll();
    }

    public List<Evaluation> findByEmployeIdAndMoisAndAnnee(Long employeId, String mois, int annee){
        return evaluationRepository.findByEmployeIdAndMoisAndAnnee(employeId, mois, annee);
    }

}
