package controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.stereotype.Controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entity.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import service.*;
import repository.*;

@Controller
public class candidat {

    @Autowired
    private CandidatService candidatService;

    @Autowired
    private AnnonceService annonceService;

    @Autowired
    private DepartementService departementService;

    @Autowired
    private DiplomeService diplomeService;

    @Autowired
    private QuestionService questionService;

    @Autowired
    private ReponseService reponseService;

    @Autowired
    private VraiReponseService vraiReponseService;

    @Autowired
    private CandidatRefuseService candidatRefuseService;

    @Autowired  
    private CandidatAdmisQcmService candidatAdmisQcmService;

    @Autowired
    private NoteQCMService noteQCMService;

    @GetMapping("/entrer")
    public String hello(Model model){
        return "index";
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate(); 
        }
        return "redirect:/entrer";
    }


    // // traitement candidat
    // @GetMapping("/formLogCandidat")
    // public String formLogCandidat(Model model) {
    //     return "candidat/formLogCandidat"; 
    // }


    // @PostMapping("/logCandidat")
    // public String logCandidat(
    //                         @RequestParam("mail") String mail,
    //                         @RequestParam("prenom") String prenom,
    //                         Model model) {
    //     var optCandidat = candidatService.login(mail, prenom);
    //     List<Annonce> annonces = annonceService.getAllAnnonces();

    //     if (optCandidat.isPresent()) {
    //         model.addAttribute("candidat", optCandidat.get());
    //         model.addAttribute("annonces", annonces);

    //     //annonce.id -> nom du département
    //     Map<Long, String> annonceDepartementMap = new HashMap<>();
    //     for (Annonce annonce : annonces) {
    //         String nomDep = departementService.getNomDepartementById((long) annonce.getIdDepartement());
    //         annonceDepartementMap.put(annonce.getId(), nomDep);
    //     }

    //     // Ajouter cette map au modèle
    //     model.addAttribute("departements", annonceDepartementMap);


    //         return "candidat/listAnnonce"; 
    //     } else {
    //         model.addAttribute("error", "Mail ou prénom incorrect.");
    //         return "candidat/formLogCandidat";
    //     }
    // }

    @GetMapping("/formLogCandidat2")
    public String formLogCandidat2(Model model) {
        List<Annonce> annonces = annonceService.getAllAnnonces();

      
        model.addAttribute("annonces", annonces);

        //annonce.id -> nom du département
        Map<Long, String> annonceDepartementMap = new HashMap<>();
        for (Annonce annonce : annonces) {
            String nomDep = departementService.getNomDepartementById((long) annonce.getIdDepartement());
            annonceDepartementMap.put(annonce.getId(), nomDep);
        }
        model.addAttribute("departements", annonceDepartementMap);
        return "candidat/listAnnonce"; 
        
    }

    
    @GetMapping("/postuleCandidat")
    public String postuleCandidat(
                            @RequestParam("id_annonce") Long id_annonce,
                            Model model) {

        Annonce annonce = annonceService.getAnnonceById(id_annonce).orElse(null);
        List <Diplome> diplome = diplomeService.findAll();
        
        
        model.addAttribute("annonce", annonce);
        model.addAttribute("diplome", diplome);

        return "candidat/FormPostule"; 

    }

    @PostMapping("/postuleCandidat")
    public String postuleCandidat(
            @RequestParam("nom") String nom,
            @RequestParam("prenom") String prenom,
            @RequestParam("mail") String mail,
            @RequestParam("adresse") String adresse,
            @RequestParam("dateNaissance") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateNaissance,
            @RequestParam("renseignement") String renseignement,
            @RequestParam("idDiplome") Integer idDiplome,
            @RequestParam("anneeExperience") Integer anneeExperience,
            @RequestParam("idDepartement") Integer idDepartement,
            @RequestParam("idAnnoncePostule") Integer idAnnoncePostule,
            @RequestParam("datePostule") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate datePostule,
            Model model,
            HttpSession session) {

        // 1️⃣ Vérifier si l'email existe déjà pour cette annonce
        if (candidatService.existsByMailAndIdAnnoncePostule(mail, idAnnoncePostule)) {
            model.addAttribute("error", "Vous avez déjà postulé pour ce poste.");
            return "candidat/erreur"; 
        }

        // 2️⃣ Vérifier si l'âge est compatible avec l'annonce
        boolean ageCompatible = annonceService.checkCV(dateNaissance, idAnnoncePostule);
        if (!ageCompatible) {
            model.addAttribute("error", "Votre âge n'est pas compatible avec l'annonce, candidature refusée.");
            return "candidat/erreur"; 
        }

        // 3️⃣ Créer le candidat et sauvegarder
        Candidat candidat = new Candidat();
        candidat.setNom(nom);
        candidat.setPrenom(prenom);
        candidat.setMail(mail);
        candidat.setAdresse(adresse);
        candidat.setDateNaissance(dateNaissance);
        candidat.setRenseignement(renseignement);
        candidat.setIdDiplome(idDiplome);
        candidat.setAnneeExperience(anneeExperience);
        candidat.setIdDepartement(idDepartement);
        candidat.setIdAnnoncePostule(idAnnoncePostule);
        candidat.setDatePostule(datePostule);

        // Sauvegarde et récupération de l'ID généré
        Candidat savedCandidat = candidatService.addCandidat(candidat);

        // Stocker l'ID dans la session
        model.addAttribute("candidat", savedCandidat);
        model.addAttribute("idDepartement", idDepartement);

        // GÉNÉRATION DES QUESTIONS ALÉATOIRES
        List<Question> allQuestions = questionService.getQuestionsByDepartement(idDepartement);
        
        // Mélanger aléatoirement et limiter à 3 questions
        Collections.shuffle(allQuestions);
        int limit = Math.min(3, allQuestions.size());
        List<Question> questions = allQuestions.subList(0, limit);
        
        // STOCKER LES QUESTIONS SÉLECTIONNÉES DANS LA SESSION
        List<Integer> questionIds = questions.stream()
                                        .map(Question::getId)
                                        .collect(Collectors.toList());
        session.setAttribute("selectedQuestionIds_" + savedCandidat.getId(), questionIds);
        
        model.addAttribute("questions", questions);

        // Map questionId -> List<Reponse>
        Map<Integer, List<Reponse>> reponsesParQuestion = new HashMap<>();
        for (Question q : questions) {
            List<Reponse> reps = reponseService.getReponsesByQuestion(q.getId());
            reponsesParQuestion.put(q.getId(), reps);
        }
        model.addAttribute("reponsesParQuestion", reponsesParQuestion);

        // pour le precheck des bonnes reponses
        Map<Integer, Integer> bonneReponseMap = vraiReponseService.getBonneReponseParQuestion(questions);
        model.addAttribute("bonneReponseMap", bonneReponseMap);

        model.addAttribute("message", "Votre candidature a été envoyée avec succès !");
        return "candidat/qcm"; 
    }

    @PostMapping("/submitQCM")
    public String submitQCM(@RequestParam Map<String, String> allParams,
                            @RequestParam("idCandidat") Integer idCandidat,
                            @RequestParam("nomCandidat") String nomCandidat,
                            Model model,
                            @RequestParam("idDepartement") Integer idDepartement,
                            HttpSession session) {

        // 1. RÉCUPÉRER LES MÊMES QUESTIONS QUE CELLES AFFICHÉES
        List<Integer> selectedQuestionIds = (List<Integer>) session.getAttribute("selectedQuestionIds_" + idCandidat);
        
        if (selectedQuestionIds == null || selectedQuestionIds.isEmpty()) {
            // Fallback : récupérer 3 questions aléatoires (ancienne méthode)
            List<Question> allQuestions = questionService.getQuestionsByDepartement(idDepartement);
            Collections.shuffle(allQuestions);
            int limit = Math.min(3, allQuestions.size());
            List<Question> questions = allQuestions.subList(0, limit);
            selectedQuestionIds = questions.stream()
                                        .map(Question::getId)
                                        .collect(Collectors.toList());
        }
        
        // 2. CHARGER LES QUESTIONS À PARTIR DE LEURS IDs
        List<Question> questions = new ArrayList<>();
        for (Integer questionId : selectedQuestionIds) {
            Optional<Question> question = questionService.getQuestionById(questionId);
            question.ifPresent(questions::add);
        }

        // 3. Récupérer le Map des bonnes réponses
        Map<Integer, Integer> bonneReponseMap = vraiReponseService.getBonneReponseParQuestion(questions);

        // 4. Compter le nombre total de questions
        int totalQuestions = questions.size();

        // 5. Compter les réponses correctes cochées
        int bonnesReponses = 0;
        for (Question q : questions) {
            String paramName = "q" + q.getId(); // correspond au name du radio input
            if (allParams.containsKey(paramName)) {
                Integer reponseChoisie = Integer.valueOf(allParams.get(paramName));
                if (bonneReponseMap.get(q.getId()).equals(reponseChoisie)) {
                    bonnesReponses++;
                }
            }
        }

        // 6. Calculer la note en pourcentage
        double note = totalQuestions == 0 ? 0 : ((double) bonnesReponses / totalQuestions) * 100;
        int notee=(int) Math.round(note);

        // 7. Envoyer les résultats vers la vue
        model.addAttribute("idCandidat", idCandidat);
        model.addAttribute("departement", departementService.getNomDepartementById(idDepartement.longValue()));
        model.addAttribute("nomCandidat", nomCandidat);
        model.addAttribute("totalQuestions", totalQuestions);
        model.addAttribute("bonnesReponses", bonnesReponses);
        model.addAttribute("note", notee);

        // 8. Sauvegarder la note
        NoteQCM noteQCM = new NoteQCM();
        noteQCM.setIdCandidat(idCandidat);
        noteQCM.setNote((int) Math.round(note));
        noteQCMService.saveNote(noteQCM);
        
        // 9. Déterminer le résultat
        if (note > 50) {
            model.addAttribute("resultat", "Félicitations, vous allez passer a l'entretien");
            candidatAdmisQcmService.addAdmis(idCandidat);
        } 
        else {
            candidatRefuseService.addRefus(idCandidat, "note_qcm");
            model.addAttribute("resultat", "Votre candidature est refusée pour note QCM faible"); 
        }

        // 10. NETTOYER LA SESSION
        session.removeAttribute("selectedQuestionIds_" + idCandidat);

        return "candidat/resultatQcm";
}
}
