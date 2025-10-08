package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import service.*;
import entity.*;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;
import java.util.Optional;

@Controller
public class rh {

    @Autowired
    private CandidatDetailsViewService candidatDetailsViewService;

    @Autowired
    private RhService rhService;

    @Autowired
    private CandidatAdmisQcmDetailsService candidatAdmisQcmDetailsService;

    @Autowired
    private CandidatRefuseDetailsService candidatRefuseDetailsService;

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
                // Ajouter la liste des candidats admis au QCM
                List<CandidatAdmisQcmDetails> candidatsAdmis = candidatAdmisQcmDetailsService.findAll();
                model.addAttribute("candidatsAdmis", candidatsAdmis);
                return "rh/acceuilRh"; 
            } else {
                model.addAttribute("error", "Nom ou mot de passe incorrect.");
                return "rh/formLogRh";
            }
        }

        @GetMapping("/accueilRh")
        public String accueilRh(Model model) {
            // Ajouter la liste des candidats admis au QCM
            List<CandidatAdmisQcmDetails> candidatsAdmis = candidatAdmisQcmDetailsService.findAll();
            model.addAttribute("candidatsAdmis", candidatsAdmis);
            return "rh/acceuilRh"; 
        }

    @GetMapping("/rh/candidats")
    public String listeCandidats(Model model) {
        List<CandidatDetailsView> candidats = candidatDetailsViewService.getAllCandidats();
        model.addAttribute("candidats", candidats);
        return "rh/listeCandidats";
    
    }

    @GetMapping("/rh/listCandidatRefuse")
    public String listCandidatRefuse(Model model) {
        try {
            List<CandidatRefuseDetails> candidatsRefuses = candidatRefuseDetailsService.findAll();
            List<String> etapesRefus = candidatRefuseDetailsService.getDistinctLibelleEtape();
            
            model.addAttribute("candidatsRefuses", candidatsRefuses);
            model.addAttribute("etapesRefus", etapesRefus);
            
            return "rh/listeRefuse";
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors du chargement des candidats refusés");
            return "rh/listeRefuse";
        }
    }

    // Génération et téléchargement du PDF
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

    @GetMapping("/rh/entretien")
    public String fairePasserEntretien(@RequestParam("id_cand") Integer idCandidat, Model model) {
        try {
            // Récupérer les détails du candidat depuis la vue
            CandidatDetailsView candidat = candidatDetailsViewService.findById(idCandidat);
            
            // Récupérer les détails de l'annonce depuis la vue des admis QCM (ou autre source)
            Optional<CandidatAdmisQcmDetails> candidatAdmis = candidatAdmisQcmDetailsService.findByIdCandidat(idCandidat);
            
            // Ajouter les données au modèle
            model.addAttribute("candidat", candidat);
            model.addAttribute("candidatAdmis", candidatAdmis.orElse(null));
            
            return "rh/entretien";
            
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors du chargement des données");
            return "rh/entretien";
        }
    }

//     voici le formulaire pour valider un entretien:
//     <!-- valider l'entretien  -->
//     <div style="border: 1px solid #ccc; padding: 15px;">
//         <h3>Notes d'entretien</h3>
//         <form method="post" action="${pageContext.request.contextPath}/rh/entretien/valider">
//             <input type="hidden" name="idCandidat" value="${candidat.id}" required>
                        
//             <div style="margin-bottom: 15px;">
//                 <label for="statut"><strong>Statut :</strong></label><br>
//                 <select id="statut" name="statut" required>
//                     <option value="">selectionner</option>
//                     <option value="essai">Validé pour periode d'essai</option>
//                     <option value="refuse">Refusé</option>
//                 </select>
//             </div>

//             <div style="margin-bottom: 15px;">
//                 <label for="periode"><strong>Periode accordee:</strong></label><br>
//                 <select name="periode" id="periode">
//                     <option value="">selectionner</option>
//                     <option value="3">3 mois</option>
//                     <option value="6">6 mois</option>
//                 </select>
//             </div>

//             <div style="margin-bottom: 15px;">
//                 <label for="salairePropose"><strong>Salaire proposé :</strong></label><br>
//                 <input type="number" id="salairePropose" name="salairePropose" placeholder="Salaire proposé en Ariary" required>
//             </div>
            
//             <button type="submit">Valider l'entretien</button>
//         </form>
//     </div>


// on va coder ce controller:
//     @PostMapping("/rh/entretien/valider")
//     public String validerEntretien(
//             @RequestParam("id_cand") Integer idCandidat,
//             @RequestParam("statut") String statut,
//             @RequestParam(value = "salaire", required = false) Integer salaire,
//             @RequestParam(value = "periode", required = false) Integer periode,
//             Model model) {

//     }


// Requester tout 
    
}
