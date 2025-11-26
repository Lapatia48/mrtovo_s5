package service;

import entity.*;
import repository.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import java.util.Map;

@Service
public class CandidatService {

        @Autowired
    private CandidatRepository candidatRepository;

    @Autowired
    private AnnonceRepository annonceRepository;

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

    public boolean existsByEmail(String mail) {
        return candidatRepository.findByMail(mail).isPresent();
    }

    public boolean existsByMailAndIdAnnoncePostule(String mail, Integer idAnnoncePostule) {
        return candidatRepository.findByMailAndIdAnnoncePostule(mail, idAnnoncePostule).isPresent();
    }



}
