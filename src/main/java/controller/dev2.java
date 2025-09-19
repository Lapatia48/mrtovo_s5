package controller;

// import entity.Candidat;
import service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import entity.Diplome;

import java.util.List;
import java.util.Map;

@Controller
public class dev2 {

    @Autowired
    private CandidatService candidatService;

    @Autowired
    private DiplomeService diplomeService;

    @GetMapping("/rh/candidats")
        public String listeCandidats(Model model) {
            List<Map<String, Object>> candidats = candidatService.getAllCandidatsAvecDetails();
            model.addAttribute("candidats", candidats);

            // ajouter la liste des diplômes pour la liste déroulante
            List<Diplome> diplomes = diplomeService.findAll();
            model.addAttribute("diplomes", diplomes);

            return "rh/listeCandidats";
        }


    @GetMapping("/rh/candidats/diplome")
    public String filtrerParDiplome(@RequestParam(name="diplome") String diplome, Model model) {
        List<Map<String, Object>> candidats = candidatService.getCandidatsFiltres("diplome", diplome);
        model.addAttribute("candidats", candidats);
        return "rh/listeCandidats";
    }


    
}
