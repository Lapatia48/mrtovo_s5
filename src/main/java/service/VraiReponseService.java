package service;

import entity.Question;
import entity.VraiReponse;
import repository.VraiReponseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class VraiReponseService {

    @Autowired
    private VraiReponseRepository vraiReponseRepository;

    public List<VraiReponse> getAllVraiReponses() { return vraiReponseRepository.findAll(); }
    public Optional<VraiReponse> getVraiReponseById(Integer id) { return vraiReponseRepository.findById(id); }
    // public List<VraiReponse> getVraiReponsesByQuestion(Integer idQuestion) { return vraiReponseRepository.findByIdQuestion(idQuestion); }
    public VraiReponse saveVraiReponse(VraiReponse vr) { return vraiReponseRepository.save(vr); }
    public void deleteVraiReponse(Integer id) { vraiReponseRepository.deleteById(id); }




    public Map<Integer, Integer> getBonneReponseParQuestion(List<Question> questions) {
        Map<Integer, Integer> bonneReponseMap = new HashMap<>();
        for (Question q : questions) {
            VraiReponse vr = vraiReponseRepository.findByIdQuestion(q.getId());
            if (vr != null) {
                bonneReponseMap.put(q.getId(), vr.getIdReponse());
            }
        }
        return bonneReponseMap;
    }



}
