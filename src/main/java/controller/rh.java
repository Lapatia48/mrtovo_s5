package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import service.*;
import entity.*;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;

import java.time.LocalDate;
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

    @Autowired
    private EssaiService essaiService;

    @Autowired
    private CandidatRefuseService candidatRefuseService;

    @Autowired
    private CandidatAdmisQcmService candidatAdmisQcmService;

    @Autowired
    private EssaiDetailService essaiDetailService;

    @Autowired
    private EmployeService employeService;

    @Autowired
    private RenouvellementEssaiService renouvellementEssaiService;

    @Autowired
    private RenouvellementEssaiDetailService renouvellementEssaiDetailService;

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

    @GetMapping("/rh/employe")
    public String listeEmployes(Model model) {
        List<Employe> employes = employeService.findAll();
        model.addAttribute("employes", employes);
        return "rh/listeEmploye";  
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
    
    @Transactional
    @PostMapping("/rh/entretien/valider")
    public String validerEntretien(
            @RequestParam("idCandidat") Integer idCandidat,
            @RequestParam("statut") String statut,
            @RequestParam(value = "salairePropose", required = false) Integer salairePropose,
            @RequestParam(value = "periode", required = false) Integer periode,
            Model model) {

        try {
            candidatAdmisQcmService.deleteAdmisByCandidat(idCandidat);
            // Traitement selon le statut
            if ("essai".equals(statut)) {
                // Validation pour période d'essai
                
                // Vérifier que les champs requis sont présents
                if (salairePropose == null || periode == null) {
                    model.addAttribute("error", "Salaire et période sont requis pour une période d'essai");
                    return "rh/entretien";
                }

                // Ajouter en période d'essai
                Essai essai = essaiService.addEssai(idCandidat, salairePropose, periode);
                
                
                if (essai != null) {
                    model.addAttribute("success", "Candidat validé pour une période d'essai de " + periode + " mois avec un salaire de " + salairePropose + " Ar");
                } else {
                    model.addAttribute("error", "Erreur lors de l'ajout en période d'essai");
                }

            } else if ("refuse".equals(statut)) {
                // Refus après entretien
                candidatRefuseService.addRefus(idCandidat, "entretien");
                                
                model.addAttribute("success", "Candidat refusé après entretien");
                List<CandidatAdmisQcmDetails> candidatsAdmis = candidatAdmisQcmDetailsService.findAll();
                model.addAttribute("candidatsAdmis", candidatsAdmis);
                return "rh/acceuilRh"; 
                
            } else {
                model.addAttribute("error", "Statut invalide");
                return "rh/entretien";
            }

            List<EssaiDetail> essaiDetails = essaiDetailService.findAll();
            model.addAttribute("essaiDetails", essaiDetails);
            return "rh/listeEssai"; 

        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors de la validation de l'entretien: " + e.getMessage());
            return "rh/entretien";
        }
    }

    @GetMapping("/rh/essai")
    public String listeEssai(Model model) {
        List<EssaiDetail> essaiDetails = essaiDetailService.findAll();
        model.addAttribute("essaiDetails", essaiDetails);
        return "rh/listeEssai"; 
    }

    @GetMapping("/essai/embauche")
    public String formEmbauche(@RequestParam("id_cand") Integer idCandidat, Model model) {
        try {
            // Récupérer les détails du candidat depuis la vue essai_detail
            EssaiDetail essaiDetail = essaiDetailService.findByIdCandidat(idCandidat);
            // Ajouter les données au modèle
            model.addAttribute("candidat", essaiDetail);
            model.addAttribute("dateEmbauche", LocalDate.now()); // Date courante par défaut
            
            return "rh/formEmploye";
            
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors du chargement des données du candidat");
            return "redirect:/rh/essai";
        }
    }

    @Transactional
    @PostMapping("/essai/embauche/valider")
    public String validerEmbauche(
            @RequestParam("idCandidat") Integer idCandidat,
            @RequestParam("nom") String nom,
            @RequestParam("prenom") String prenom,
            @RequestParam("mail") String mail,
            @RequestParam("adresse") String adresse,
            @RequestParam("dateNaissance") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateNaissance,
            @RequestParam("diplome") String diplome,
            @RequestParam("anneeExperience") String anneeExperience,
            @RequestParam("departement") String departement,
            @RequestParam("annoncePostulee") String annoncePostulee,
            @RequestParam("motDePasse") String motDePasse,
            @RequestParam("confirmationMotDePasse") String confirmationMotDePasse,
            @RequestParam("dateEmbauche") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateEmbauche,
            @RequestParam("poste") String poste,
            @RequestParam("salaire") Integer salaire,
            @RequestParam(value = "renseignement", required = false) String renseignement,
            Model model) {

        try {
            // Validation des mots de passe
            if (!motDePasse.equals(confirmationMotDePasse)) {
                model.addAttribute("error", "Les mots de passe ne correspondent pas");
                return "rh/formEmploye";
            }

            // Extraire l'année d'expérience du texte
            Integer anneeExp = extractAnneeExperience(anneeExperience);

            // Créer l'employé
            Employe employe = new Employe();
            employe.setIdCandidat(idCandidat);
            employe.setNom(nom);
            employe.setPrenom(prenom);
            employe.setMail(mail);
            employe.setMotDePasse(motDePasse); // À hasher en production!
            employe.setAdresse(adresse);
            employe.setDateNaissance(dateNaissance);
            employe.setRenseignement(renseignement);
            employe.setDiplome(diplome); // Directement le texte
            employe.setAnneeExperience(anneeExp);
            employe.setDepartement(departement); // Directement le texte
            employe.setPoste(poste); // Utilise le poste du formulaire
            employe.setDateEmbauche(dateEmbauche);
            employe.setSalaire(salaire);
            employe.setStatut("actif");

            // Sauvegarder l'employé
            employeService.save(employe);

            // Supprimer de la table essai
            essaiService.deleteEssaiByCandidat(idCandidat);

            model.addAttribute("success", "Employé embauché avec succès !");
            List<Employe> employes = employeService.findAll();
            model.addAttribute("employes", employes);
            return "rh/listeEmploye"; 

        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors de l'embauche: " + e.getMessage());
            return "rh/formEmploye";
        }
    }

    // Méthode utilitaire pour extraire l'année d'expérience
    private Integer extractAnneeExperience(String anneeExperienceText) {
        try {
            // Extraire le nombre du texte (ex: "5 ans" -> 5)
            java.util.regex.Pattern pattern = java.util.regex.Pattern.compile("(\\d+)");
            java.util.regex.Matcher matcher = pattern.matcher(anneeExperienceText);
            if (matcher.find()) {
                return Integer.parseInt(matcher.group(1));
            }
        } catch (Exception e) {
            // En cas d'erreur, retourner 0
        }
        return 0;
    }

    @GetMapping("/rh/essaiRenouv")
    public String listeEssaiRenouv(Model model) {
        List<RenouvellementEssaiDetail> renouvellementEssaiDetails = renouvellementEssaiDetailService.findAll();
        model.addAttribute("essaiDetails", renouvellementEssaiDetails);
        return "rh/listeEssaiRenouv"; 
    }

    @GetMapping("/essai/renouv")
    public String formRenouvellement(@RequestParam("id_cand") Integer idCandidat, Model model) {
        try {
            // Récupérer les détails du candidat depuis la vue essai_detail
            EssaiDetail essaiDetail = essaiDetailService.findByIdCandidat(idCandidat);
            
            if (essaiDetail == null) {
                model.addAttribute("error", "Candidat non trouvé");
                return "redirect:/rh/essai";
            }
            
            // Ajouter les données au modèle
            model.addAttribute("candidat", essaiDetail);
            
            return "rh/renouvellement";
            
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors du chargement des données du candidat");
            return "redirect:/rh/essai";
        }
    }

    @GetMapping("/renouv/embauche")
    public String formEmbaucheRenouv(@RequestParam("id_cand") Integer idCandidat, Model model) {
        try {
            // Récupérer les détails du candidat depuis la vue essai_detail
            RenouvellementEssaiDetail essaiDetail = renouvellementEssaiDetailService.findByIdCandidat(idCandidat);
            // Ajouter les données au modèle
            model.addAttribute("candidat", essaiDetail);
            model.addAttribute("dateEmbauche", LocalDate.now()); // Date courante par défaut
            
            return "rh/formEmploye";
            
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors du chargement des données du candidat");
            return "redirect:/rh/essai";
        }
    }

    @Transactional
    @PostMapping("/essai/renouv/valider")
    public String validerRenouvellement(
            @RequestParam("idCandidat") Integer idCandidat,
            @RequestParam("statut") String statut,
            @RequestParam("salaire") Integer salaire,
            @RequestParam("periode") Integer periode,
            Model model) {

        try {
            // Vérifier que le candidat existe
            EssaiDetail essaiDetail = essaiDetailService.findByIdCandidat(idCandidat);
            if (essaiDetail == null) {
                model.addAttribute("error", "Candidat non trouvé");
                return "redirect:/rh/essai";
            }

            // Traitement du renouvellement
            if ("renouveler".equals(statut)) {
                // Ajouter dans renouvellement_essai
                RenouvellementEssai renouvellement = renouvellementEssaiService.addRenouvellement(idCandidat, salaire, periode);
                
                // Supprimer de la table essai
                essaiService.deleteEssaiByCandidat(idCandidat);
                
                if (renouvellement != null) {
                    model.addAttribute("success", "Essai renouvelé pour " + periode + " mois avec un salaire de " + salaire + " Ar");
                } else {
                    model.addAttribute("error", "Erreur lors du renouvellement de l'essai");
                }

            } else {
                model.addAttribute("error", "Statut invalide");
                return "rh/renouvellement";
            }

            // Rediriger vers la liste des essais renouvelle
            List<RenouvellementEssaiDetail> renouvellementEssaiDetails = renouvellementEssaiDetailService.findAll();
            model.addAttribute("essaiDetails", renouvellementEssaiDetails);
            return "rh/listeEssaiRenouv"; 

        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors du renouvellement de l'essai: " + e.getMessage());
            return "rh/renouvellement";
        }
    }

    // @GetMapping("/essai/refuse")
    @Transactional
    @GetMapping("/essai/refuse")
    public String refuserEssai(@RequestParam("id_cand") Integer idCandidat, Model model) {
        try {
            // Vérifier que le candidat existe
            EssaiDetail essaiDetail = essaiDetailService.findByIdCandidat(idCandidat);
            if (essaiDetail == null) {
                model.addAttribute("error", "Candidat non trouvé");
                return "redirect:/rh/essai";
            }

            // Ajouter le refus
            candidatRefuseService.addRefus(idCandidat, "periode essai");
            
            // Supprimer de la table essai
            essaiService.deleteEssaiByCandidat(idCandidat);
            
            model.addAttribute("success", "Candidat refusé après période d'essai");
            return "redirect:/accueilRh";

        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors du refus: " + e.getMessage());
            return "redirect:/rh/essai";
        }
    }
    // @GetMapping("/essai/refuseRenouv")
    @Transactional
    @GetMapping("/essai/refuseRenouv")
    public String refuserRenouvellement(@RequestParam("id_cand") Integer idCandidat, Model model) {
        try {
            // Vérifier que le candidat existe dans les renouvellements
            RenouvellementEssaiDetail renouvellementDetail = renouvellementEssaiDetailService.findByIdCandidat(idCandidat);
            if (renouvellementDetail == null) {
                model.addAttribute("error", "Candidat non trouvé dans les renouvellements");
                return "redirect:/rh/renouvellements"; // À adapter selon votre route
            }

            // Ajouter le refus
            candidatRefuseService.addRefus(idCandidat, "renouvellement essai");
            
            // Supprimer de la table renouvellement_essai
            renouvellementEssaiService.deleteRenouvellementByCandidat(idCandidat);
            
            model.addAttribute("success", "Candidat refusé après renouvellement d'essai");
            return "redirect:/accueilRh"; // À adapter selon votre route

        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors du refus: " + e.getMessage());
            return "redirect:/rh/renouvellements"; // À adapter selon votre route
        }
    }


    
}
