package controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.stereotype.Controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

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
public class dev1 {

    @Autowired
    private CandidatService candidatService;

    @Autowired
    private RhService rhService;

    @Autowired
    private AdminService adminService;

    @Autowired
    private ManagerService managerService;

    @Autowired
    private AnnonceService annonceService;

    @Autowired
    private DepartementService departementService;

    @Autowired
    private DiplomeService diplomeService;

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


    // traitement candidat
    @GetMapping("/formLogCandidat")
    public String formLogCandidat(Model model) {
        return "candidat/formLogCandidat"; 
    }


    @PostMapping("/logCandidat")
    public String logCandidat(
                            @RequestParam("mail") String mail,
                            @RequestParam("prenom") String prenom,
                            Model model) {
        var optCandidat = candidatService.login(mail, prenom);
        List<Annonce> annonces = annonceService.getAllAnnonces();

        if (optCandidat.isPresent()) {
            model.addAttribute("candidat", optCandidat.get());
            model.addAttribute("annonces", annonces);

        //annonce.id -> nom du département
        Map<Long, String> annonceDepartementMap = new HashMap<>();
        for (Annonce annonce : annonces) {
            String nomDep = departementService.getNomDepartementById((long) annonce.getIdDepartement());
            annonceDepartementMap.put(annonce.getId(), nomDep);
        }

        // Ajouter cette map au modèle
        model.addAttribute("departements", annonceDepartementMap);


            return "candidat/listAnnonce"; 
        } else {
            model.addAttribute("error", "Mail ou prénom incorrect.");
            return "candidat/formLogCandidat";
        }
    }

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
            Model model) {

        // Création d'un nouvel objet Candidat
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

        // Sauvegarde via le service
        candidatService.addCandidat(candidat);

        // Feedback + redirection ou vue
        model.addAttribute("message", "Votre candidature a été envoyée avec succès !");
        return "candidat/qcm"; 
    }

    




    // traitement login rh
    @GetMapping("/formLogRh")
        public String formLogRh(Model model) {
        return "rh/formLogRh"; 
    }

    @PostMapping("/logRh")
    public String logRh(
                            @RequestParam("nom") String nom,
                            @RequestParam("motDePasse") String motDePasse,
                            Model model) {
        var optRh = rhService.login(nom, motDePasse);
        if (optRh.isPresent()) {
            model.addAttribute("rg", optRh.get());
            return "rh/acceuilRh"; 
        } else {
            model.addAttribute("error", "Nom ou mot de passe incorrect.");
            return "rh/formLogRh";
        }
    }

    // traitement login admin
    @GetMapping("/formLogAdmin")
    public String formLogAdmin(Model model) {
        return "admin/formLogAdmin"; 
    }

    @PostMapping("/logAdmin")
    public String logAdmin(
                            @RequestParam("nom") String nom,
                            @RequestParam("motDePasse") String motDePasse,
                            Model model) {
        var optAdmin = adminService.login(nom, motDePasse);
        if (optAdmin.isPresent()) {
            model.addAttribute("admin", optAdmin.get());
            return "admin/accueilAdmin"; 
        } else {
            model.addAttribute("error", "Nom ou mot de passe incorrect.");
            return "admin/formLogAdmin";
        }
    }

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
}
