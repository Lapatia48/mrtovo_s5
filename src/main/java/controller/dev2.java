package controller;

import service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import entity.*;

import java.util.List;
import java.util.Map;

@Controller
public class dev2 {

    @Autowired
    private CandidatService candidatService;

    @Autowired
    private DiplomeService diplomeService;

    @Autowired
    private DepartementService departementService;

    @GetMapping("/rh/candidats")
        public String listeCandidats(Model model) {
            List<Map<String, Object>> candidats = candidatService.getAllCandidatsAvecDetails();
            model.addAttribute("candidats", candidats);

            // liste des deroulantes
            List<Diplome> diplomes = diplomeService.findAll();
            model.addAttribute("diplomes", diplomes);
            List<Departement> departements = departementService.findAll();
            model.addAttribute("departements", departements);

            return "rh/listeCandidats";
        }


    @GetMapping("/rh/candidats/diplome")
    public String filtrerParDiplome(@RequestParam(name = "diplome", required = false) String diplome,
                                    @RequestParam(name = "departement", required = false) String departement,
                                    Model model) {

        List<Map<String, Object>> candidats;

        if ((diplome != null && !diplome.isEmpty()) && (departement != null && !departement.isEmpty())) {
            // Si les deux sont remplis → filtrer deux fois
            List<Map<String, Object>> parDiplome = candidatService.getCandidatsFiltres("diplome", diplome);
            candidats = parDiplome.stream()
                    .filter(c -> departement.equals(c.get("departement")))
                    .toList();
        } else if (diplome != null && !diplome.isEmpty()) {
            // Si seulement diplome
            candidats = candidatService.getCandidatsFiltres("diplome", diplome);
        } else if (departement != null && !departement.isEmpty()) {
            // Si seulement departement
            candidats = candidatService.getCandidatsFiltres("departement", departement);
        } else {
            // Si aucun filtre → tout afficher
            candidats = candidatService.getAllCandidatsAvecDetails();
        }

        model.addAttribute("candidats", candidats);

        // listes déroulantes
        List<Diplome> diplomes = diplomeService.findAll();
        model.addAttribute("diplomes", diplomes);
        List<Departement> departementsList = departementService.findAll();
        model.addAttribute("departements", departementsList);

        return "rh/listeCandidats";
    }



    
}
