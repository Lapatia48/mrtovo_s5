package controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.stereotype.Controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entity.*;
import jakarta.transaction.Transactional;
import service.*;

@Controller
public class manager {

    @Autowired
    private ManagerService managerService;

    @Autowired
    private DepartementService departementService;

    @Autowired
    private DiplomeService diplomeService;

    @Autowired
    private AnnonceService annonceService;

    @Autowired
    private QuestionsReponsesViewService questionsReponsesViewService;

    @Autowired
    private QuestionService questionService;

    @Autowired
    private ReponseService reponseService;

    @Autowired
    private VraiReponseService vraiReponseService;

    //traitement manager
    @GetMapping("/formLogManager")
    public String formLogManager(Model model) {
        return "manager/formLogManager"; 
    }

    @PostMapping("/logManager")
    public String logManager(
                            @RequestParam("nom") String nom,
                            @RequestParam("motDePasse") String motDePasse,
                            Model model) {

        var optManager = managerService.login(nom, motDePasse);
        if (optManager.isPresent()) {

            // model.addAttribute("manager", optManager.get());
            model.addAttribute("departements", departementService.findAll());
            model.addAttribute("diplomes", diplomeService.findAll());


            return "manager/accueilManager"; 
        } else {
            model.addAttribute("error", "Nom ou mot de passe incorrect.");
            return "manager/formLogManager";
        }
    }

    @PostMapping("/ajoutAnnonce")
    public String ajoutAnnonce(
                            @RequestParam("idDepartement") Integer idDepartement,
                            @RequestParam("titre") String titre,
                            @RequestParam("ageMin") Integer ageMin,
                            @RequestParam("ageMax") Integer ageMax,
                            @RequestParam("description") String description,
                            @RequestParam("nbPersonneUtile") Integer nbPersonneUtile,
                            @RequestParam("salaire") Integer salaire,
                            @RequestParam("idDiplomeRequis") Integer idDiplomeRequis,
                            Model model) {

        Annonce annonce = new Annonce();
        annonce.setIdDepartement(idDepartement);
        annonce.setTitre(titre);
        annonce.setDescription(description);
        annonce.setAgeMin(ageMin);
        annonce.setAgeMax(ageMax);
        annonce.setDatePublication(java.time.LocalDate.now());
        annonce.setNbPersonneUtile(nbPersonneUtile);
        annonce.setSalaire(salaire);
        annonce.setIdDiplomeRequis(idDiplomeRequis);

        annonceService.save(annonce);

        model.addAttribute("message", "Annonce ajoutée avec succes");
        model.addAttribute("departements", departementService.findAll());
        model.addAttribute("diplomes", diplomeService.findAll());

        return "manager/accueilManager"; 
    }

    @GetMapping("/listAnnonceManager")
    public String listAnnonce(Model model) {
        List<Annonce> annonces = annonceService.getAllAnnonces();
        model.addAttribute("annonces", annonces);
        return "manager/listAnnonce"; 
    }

    @GetMapping("/supprimerAnnonce")
    public String supprimerAnnonce(@RequestParam("id") Long id, RedirectAttributes redirectAttributes) {
        try {
            annonceService.deleteAnnonce(id);
            redirectAttributes.addFlashAttribute("successMessage", "Annonce supprimée avec succès !");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Erreur lors de la suppression de l'annonce.");
        }
        return "redirect:/listAnnonceManager";
    }

    @GetMapping("/accueilManager")
    public String accueilManager(Model model){
       return "manager/accueilManager";
    }

    // 1-afficher
    @GetMapping("/updateAnnonce")
    public String showUpdateForm(@RequestParam("id") Long id, Model model) {
        Optional<Annonce> annonceOptional = annonceService.getAnnonceById(id);

        if (annonceOptional.isPresent()) {
            model.addAttribute("annonce", annonceOptional.get());
            return "manager/updateAnnonceForm"; // Vue du formulaire
        } else {
            // ID non trouvé → redirection ou message d'erreur
            return "redirect:/listeAnnonces?error=notfound";
        }
    }


    // 2️⃣ Traiter la soumission du formulaire
    @PostMapping("/updateAnnonce")
    public String updateAnnonce(Annonce annonce) {
        annonceService.updateAnnonce(annonce); // Sauvegarde les modifications
        return "redirect:/listAnnonceManager"; // Redirige vers la liste des annonces
    }


    @GetMapping("/manager/listQcm")
    public String listQcm(Model model) {
        List<QuestionsReponsesView> questionsReponses = questionsReponsesViewService.findAll();
        List<Departement> departements = departementService.findAll();
        
        model.addAttribute("questionsReponses", questionsReponses);
        model.addAttribute("departements", departements);
        
        return "manager/listeQcm";
    }

    @Transactional
    @GetMapping("/manager/supprimerQcm")
    public String supprimerQcm(@RequestParam("id_question") Integer id, Model model) {

        questionService.deleteQuestion(id);

        List<QuestionsReponsesView> questionsReponses = questionsReponsesViewService.findAll();
        List<Departement> departements = departementService.findAll();
        model.addAttribute("questionsReponses", questionsReponses);
        model.addAttribute("departements", departements);

        return "manager/listeQcm";
    }


    @GetMapping("/manager/createQcm")
    public String showCreateQcmForm(Model model) {
        List<Departement> departements = departementService.findAll();
        model.addAttribute("departements", departements);
        return "manager/formCreateQcm";
    }

    @PostMapping("/manager/insertQcm")
    public String insertQcm(@RequestParam("id_departement") Integer idDepartement,
                        @RequestParam("question") String question,
                        @RequestParam("reponses") List<String> reponses,
                        @RequestParam("reponse_correcte") Integer indexReponseCorrecte,
                        Model model) {
        
        // 1. Insérer la question
        Question nouvelleQuestion = new Question();
        nouvelleQuestion.setQuestion(question);
        nouvelleQuestion.setIdDepartement(idDepartement);
        Question questionSauvee = questionService.saveQuestion(nouvelleQuestion);
        
        // 2. Insérer les réponses
        List<Reponse> reponsesSauvees = new ArrayList<>();
        for (int i = 0; i < reponses.size(); i++) {
            Reponse reponse = new Reponse();
            reponse.setIdQuestion(questionSauvee.getId());
            reponse.setReponse(reponses.get(i));
            Reponse reponseSauvee = reponseService.saveReponse(reponse);
            reponsesSauvees.add(reponseSauvee);
        }
        
        // 3. Insérer la vraie réponse
        VraiReponse vraiReponse = new VraiReponse();
        vraiReponse.setIdQuestion(questionSauvee.getId());
        vraiReponse.setIdReponse(reponsesSauvees.get(indexReponseCorrecte).getId());
        vraiReponseService.saveVraiReponse(vraiReponse);

        List<QuestionsReponsesView> questionsReponses = questionsReponsesViewService.findAll();
        List<Departement> departements = departementService.findAll();
        model.addAttribute("questionsReponses", questionsReponses);
        model.addAttribute("departements", departements);
        return "manager/listeQcm";
    }

    // @GetMapping("/manager/modifierQcm")
    // public String modifierQcm(@RequestParam("id_question") Integer id, Model model) {
        
    //     return "manager/modifierQcm";
    // }  
    

}