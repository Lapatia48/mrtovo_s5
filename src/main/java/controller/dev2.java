package controller;

import service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import entity.*;
import jakarta.servlet.http.HttpServletResponse;
import repository.CandidatAdmisQcmRepository;
import repository.CandidatRefuseRepository;
import repository.CandidatRepository;
import repository.EntretienRepository;

import java.time.LocalDate;
import java.util.List;
// import java.util.Map;

@Controller
public class dev2 {

    // @Autowired
    // private CandidatService candidatService;

    @Autowired
    private DiplomeService diplomeService;

    @Autowired
    private DepartementService departementService;

    @Autowired
    private CandidatDetailsViewService candidatDetailsViewService;

  
    // @GetMapping("/rh/candidats/diplome")
    // public String filtrerParDiplome(@RequestParam(name = "diplome", required = false) String diplome,
    //                                 @RequestParam(name = "departement", required = false) String departement,
    //                                 Model model) {

    //     List<Map<String, Object>> candidats;

    //     if ((diplome != null && !diplome.isEmpty()) && (departement != null && !departement.isEmpty())) {
    //         List<Map<String, Object>> parDiplome = candidatService.getCandidatsFiltres("diplome", diplome);
    //         candidats = parDiplome.stream()
    //                 .filter(c -> departement.equals(c.get("departement")))
    //                 .toList();
    //     } else if (diplome != null && !diplome.isEmpty()) {
    //         candidats = candidatService.getCandidatsFiltres("diplome", diplome);
    //     } else if (departement != null && !departement.isEmpty()) {
    //         candidats = candidatService.getCandidatsFiltres("departement", departement);
    //     } else {
    //         candidats = candidatService.getAllCandidatsAvecDetails();
    //     }

    //     model.addAttribute("candidats", candidats);

    //     // listes déroulantes
    //     List<Diplome> diplomes = diplomeService.findAll();
    //     model.addAttribute("diplomes", diplomes);
    //     List<Departement> departementsList = departementService.findAll();
    //     model.addAttribute("departements", departementsList);

    //     return "rh/listeCandidats";
    // }


    @GetMapping("/rh/candidats")
    public String listeCandidats(Model model) {


    List<CandidatDetailsView> candidats = candidatDetailsViewService.getAllCandidats();
    model.addAttribute("candidats", candidats);

    // liste des deroulantes
    List<Diplome> diplomes = diplomeService.findAll();
    model.addAttribute("diplomes", diplomes);
    List<Departement> departements = departementService.findAll();
    model.addAttribute("departements", departements);

    return "rh/listeCandidats";
    
    }

    @GetMapping("/rh/candidats/filtrer")
    public String filtrerCandidat(
            @RequestParam(value = "nom", required = false) String nom,
            @RequestParam(value = "diplome", required = false) String diplome,
            @RequestParam(value = "departement", required = false) String departement,
            @RequestParam(value = "age", required = false) String ageOrder,
            @RequestParam(value = "anneeExperience", required = false) String experienceOrder,
            @RequestParam(value = "datePostule", required = false) String datePostuleOrder,
            Model model) {

        // Appel du service avec filtres
        List<CandidatDetailsView> candidats = candidatDetailsViewService.filterAndSort(
                nom, diplome, departement, ageOrder, experienceOrder, datePostuleOrder
        );

        model.addAttribute("candidats", candidats);

        // liste des déroulantes
        List<Diplome> diplomes = diplomeService.findAll();
        model.addAttribute("diplomes", diplomes);

        List<Departement> departements = departementService.findAll();
        model.addAttribute("departements", departements);

        return "rh/listeCandidats";
    }

    @GetMapping("/rh/candidats/pdf")
    public void generatePdf(@RequestParam("id_cand") Integer id, HttpServletResponse response) throws Exception {
        // Génération du PDF dans un fichier local
        String fileName = candidatDetailsViewService.toPdf(id);

        java.nio.file.Path path = java.nio.file.Paths.get(fileName);

        // Définir le type MIME et forcer le téléchargement AVANT de copier le contenu
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        response.setContentLengthLong(java.nio.file.Files.size(path));

        // Copier le contenu du PDF dans le flux de réponse
        java.nio.file.Files.copy(path, response.getOutputStream());
        response.getOutputStream().flush();
    }

   @Autowired
    private CandidatQCMService qcmService;

    @Autowired
    private CandidatAdmisQcmRepository admisRepo;

    @Autowired
    private CandidatRefuseRepository refuseRepo;
    
    @Autowired
    private EntretienRepository entretienRepo;

    @Autowired
    private EntretienService entretienService;

    @Autowired
    private EssaiService essaiService;

    @Autowired
    private CandidatRepository candidatRepo;


    // Traiter les candidats
    @GetMapping("/rh/qcm/traiter")
    public String traiter(Model model) {
        qcmService.traiterCandidatsQCM();

        List<CandidatAdmisQcm> admis = admisRepo.findAll();
        List<CandidatRefuse> refuses = refuseRepo.findAll();

        qcmService.enrichirInfosCandidats(admis, refuses);

        model.addAttribute("admis", admis);
        model.addAttribute("refuses", refuses);

        return "/rh/resultats-qcm";
    }

    @GetMapping("/rh/qcm/admis")
    public String voirAdmis(Model model) {
        List<CandidatAdmisQcm> admis = admisRepo.findAll();
        qcmService.enrichirInfosCandidats(admis, List.of());
        model.addAttribute("admis", admis);
        return "rh/admis-qcm"; // 
    }

    // ✅ Page : uniquement refusés
    @GetMapping("/rh/qcm/refuses")
    public String voirRefuses(Model model) {
        List<CandidatRefuse> refuses = refuseRepo.findAll();
        qcmService.enrichirInfosCandidats(List.of(), refuses);
        model.addAttribute("refuses", refuses);
        return "rh/refuses-qcm"; // ✅ JSP refusés
    }

    
    // @GetMapping("/rh/qcm/validation-entretien")
    // public String afficherValidationEntretien() {
    //     // Cela redirige simplement vers la JSP située dans /WEB-INF/views/rh/validation-entretien.jsp
    //     return "rh/validation-entretien";
    // }


    @GetMapping("/rh/qcm/validation-entretien")
    public String listeValidation(Model model) {
        // Récupérer tous les candidats admis au QCM
        List<CandidatAdmisQcm> admis = admisRepo.findAll();

        // Filtrer ceux qui n'ont pas encore d'entretien
        List<CandidatAdmisQcm> candidatsATraiter = admis.stream()
                .filter(a -> !entretienService.existsEntretien(a.getIdCandidat()))
                .toList();

        // Enrichir infos pour affichage
        qcmService.enrichirInfosCandidats(candidatsATraiter, List.of());

        model.addAttribute("candidats", candidatsATraiter);
        return "rh/validation-entretien";
    }

    @PostMapping("/rh/qcm/validation-entretien/{idCandidat}")
    public String validerCandidat(@PathVariable("idCandidat") Integer idCandidat,
                                @RequestParam String statut) {
        entretienService.validerEntretien(idCandidat, statut, "Validation via RH", LocalDate.now());
        return "redirect:/rh/qcm/validation-entretien";
    }

    
    @GetMapping("/rh/essai/liste")
    public String listeCandidatsEssai(Model model) {
        List<Candidat> candidats = candidatRepo.findAll().stream()
            .filter(c -> entretienRepo.existsById(c.getId()))
            .toList();
        model.addAttribute("candidats", candidats);
        return "rh/essai-liste"; // JSP
    }

    @PostMapping("/rh/essai/valider/{idCandidat}")
    public String validerCandidat(@PathVariable("idCandidat") Integer idCandidat,
                                @RequestParam(required = false) Integer periode) {
        if (periode == null) periode = 3;
        essaiService.passerEnEssai(idCandidat, periode);
        return "redirect:/rh/essai/liste"; 
    }

    
}
