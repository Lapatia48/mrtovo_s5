package controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.stereotype.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import entity.*;
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

    @GetMapping("/entrer")
    public String hello(Model model){
        return "index";
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

    //traitement login manager
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
            model.addAttribute("manager", optManager.get());
            return "manager/accueilManager"; 
        } else {
            model.addAttribute("error", "Nom ou mot de passe incorrect.");
            return "manager/formLogManager";
        }
    }


}
