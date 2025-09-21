package service;

import entity.*;
import repository.*;
import org.springframework.stereotype.Service;
// import service.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import java.util.Map;

@Service
public class CandidatService {

    private final CandidatRepository candidatRepository;

    public CandidatService(CandidatRepository candidatRepository) {
        this.candidatRepository = candidatRepository;
    }

    // Ajouter un candidat
    public Candidat addCandidat(Candidat candidat) {
        return candidatRepository.save(candidat);
    }

    // Récupérer tous les candidats
    public List<Candidat> getAllCandidats() {
        return candidatRepository.findAll();
    }

    // Récupérer un candidat par son ID
    public Optional<Candidat> getCandidatById(Integer id) {
        return candidatRepository.findById(id);
    }

    // Mettre à jour un candidat
    public Candidat updateCandidat(Candidat candidat) {
        return candidatRepository.save(candidat);
    }

    // Supprimer un candidat
    public void deleteCandidat(Integer id) {
        candidatRepository.deleteById(id);
    }


    // Login
    public Optional<Candidat> login(String mail, String prenom) {
        return candidatRepository.findByMailAndPrenom(mail, prenom);
    }


    public List<Map<String, Object>> getAllCandidatsAvecDetails() {
        List<Object[]> results = candidatRepository.findAllCandidatsWithDetails();
        List<Map<String, Object>> list = new ArrayList<>();

        for (Object[] r : results) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", r[0]);
            map.put("nom", r[1]);
            map.put("prenom", r[2]);
            map.put("mail", r[3]);
            map.put("adresse", r[4]);
            map.put("dateNaissance", r[5]);
            map.put("age", r[6]);   
            map.put("renseignement", r[7]);
            map.put("anneeExperience", r[8]);
            map.put("datePostule", r[9]);
            map.put("diplome", r[10]);
            map.put("departement", r[11]);

            list.add(map);
        }

        return list;
    }



    
    public List<Map<String, Object>> getCandidatsFiltres(String champ, Object valeur) {
        List<Object[]> results = candidatRepository.findAllCandidatsWithDetails();
        List<Map<String, Object>> list = new ArrayList<>();

        // correspondance champ → index
        Map<String, Integer> indexMapping = new HashMap<>();
        indexMapping.put("id", 0);
        indexMapping.put("nom", 1);
        indexMapping.put("prenom", 2);
        indexMapping.put("mail", 3);
        indexMapping.put("adresse", 4);
        indexMapping.put("dateNaissance", 5);
        indexMapping.put("age", 6);   
        indexMapping.put("renseignement", 7);
        indexMapping.put("anneeExperience", 8);
        indexMapping.put("datePostule", 9);
        indexMapping.put("diplome", 10);
        indexMapping.put("departement", 11);


        Integer index = indexMapping.get(champ);

        if (index == null) {
            throw new IllegalArgumentException("Champ inconnu : " + champ);
        }

        for (Object[] r : results) {
            Object champValue = r[index];

            if (champValue != null && champValue.equals(valeur)) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", r[0]);
            map.put("nom", r[1]);
            map.put("prenom", r[2]);
            map.put("mail", r[3]);
            map.put("adresse", r[4]);
            map.put("dateNaissance", r[5]);
            map.put("age", r[6]);   
            map.put("renseignement", r[7]);
            map.put("anneeExperience", r[8]);
            map.put("datePostule", r[9]);
            map.put("diplome", r[10]);
            map.put("departement", r[11]);


                list.add(map);
            }
        }

        return list;
    }

    public boolean existsByEmail(String mail) {
        return candidatRepository.findByMail(mail).isPresent();
    }


}
