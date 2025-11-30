package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import service.*;
import entity.*;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;
import repository.EmployeRepository;

import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;



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

    @Autowired
    private AnnonceDetailCandidatService annonceDetailCandidatService;

    @Autowired
    private GeminiService geminiService;  

    @Autowired
    private ContratEmployeViewService contratEmployeViewService;

    // Ajouter ces injections dans votre contrôleur
    @Autowired
    private ContratService contratService;

    // AJOUTEZ CETTE INJECTION
    @Autowired
    private FicheEmployeCompleteViewService ficheEmployeCompleteViewService;

    @Autowired
    private FicheEmployeService ficheEmployeService;

    @Autowired
    private EvaluationService evaluationService;

    @GetMapping("/chatbot")
    public String chatbot() {
        return "rh/chatbot";
    }

    @PostMapping("/ask")
    public String askQuestion(@RequestParam(name = "question") String question, Model model) {
        String answer = geminiService.processQuestion(question);  
        model.addAttribute("answer", answer);
        return "rh/chatbot";
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
   @GetMapping("/rh/employe/evaluation")
    public String afficherEvaluation(@RequestParam("id_employe") Long id, Model model) {
        Optional<Employe> employeOpt = employeService.findById(id.intValue());
        if (employeOpt.isPresent()) {
            model.addAttribute("employe", employeOpt.get());
            return "rh/evaluation"; // JSP à créer
        } else {
            // Si l'employé n'existe pas, on redirige vers la liste
            return "redirect:/rh/employe";
        }
    }

@PostMapping("/rh/employe/evaluation/soumettre")
public String soumettreEvaluation(@RequestParam("id_employe") Long id_employe,
                                  @RequestParam("mois") String mois,
                                  @RequestParam("annee") int annee,
                                  @RequestParam("note") int note,
                                  Model model) {

    List<Evaluation> existantes = evaluationService.findByEmployeIdAndMoisAndAnnee(id_employe, mois, annee);

    if (!existantes.isEmpty()) {
        model.addAttribute("error", " Scoring déjà existant pour cet employé ce mois-là.");
      
        return "rh/evaluation";
    } else {
        
        evaluationService.enregistrerEvaluation(id_employe, mois, annee, note);
        return "redirect:/rh/employe";
    }
}

    @GetMapping("/rh/employe/scoring")
    public String afficherScoring(Model model) {
        List<Evaluation> evaluations = evaluationService.getToutesLesEvaluations();
        model.addAttribute("evaluations", evaluations);
        return "rh/scoring";
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
            
            // Récupérer les détails de l'annonce depuis la nouvelle vue
            Optional<AnnonceDetailCandidat> annonceDetail = annonceDetailCandidatService.findByIdCandidat(idCandidat);
            
            // Ajouter les données au modèle
            model.addAttribute("candidat", candidat);
            model.addAttribute("candidatAdmis", candidatAdmis.orElse(null));
            model.addAttribute("annonce", annonceDetail.orElse(null));
            
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
            @RequestParam("typeContrat") String typeContrat,
            @RequestParam("classification") String classification,
            @RequestParam("periodeEssai") Integer periodeEssai,
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
            employe.setMotDePasse(motDePasse);
            employe.setAdresse(adresse);
            employe.setDateNaissance(dateNaissance);
            employe.setRenseignement(renseignement);
            employe.setDiplome(diplome);
            employe.setAnneeExperience(anneeExp);
            employe.setDepartement(departement);
            employe.setPoste(poste);
            employe.setDateEmbauche(dateEmbauche);
            employe.setSalaire(salaire);
            employe.setStatut("actif");

            // CORRECTION : Sauvegarder l'employé (pas employeService)
            Employe savedEmploye = employeService.save(employe);

            // === CRÉATION AUTOMATIQUE DU CONTRAT ===
            Contrat contrat = new Contrat();
            contrat.setIdEmploye(savedEmploye.getId());
            contrat.setNumeroContrat(genererNumeroContrat(typeContrat));
            contrat.setTypeContrat(typeContrat);
            contrat.setDateDebut(dateEmbauche); // Utilise le paramètre
            contrat.setPoste(poste); // Utilise le paramètre
            contrat.setClassification(classification);
            contrat.setSalaireBase(BigDecimal.valueOf(salaire));
            contrat.setPeriodeEssaiJours(periodeEssai);
            
            // Pour CDD, définir la date de fin (1 an par défaut)
            if ("CDD".equals(typeContrat)) {
                contrat.setDateFin(dateEmbauche.plusYears(1));
            }
            
            // Définir la fin de période d'essai si applicable
            if (periodeEssai > 0) {
                contrat.setDateFinEssai(dateEmbauche.plusDays(periodeEssai));
            }
            
            contratService.save(contrat);
            // === FIN CRÉATION CONTRAT ===

            // Supprimer de la table essai
            essaiService.deleteEssaiByCandidat(idCandidat);

            model.addAttribute("success", "Employé embauché avec succès ! Contrat " + contrat.getNumeroContrat() + " créé.");
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


    // ITO MODIFIER
    // Méthode pour générer un numéro de contrat unique
    private String genererNumeroContrat(String typeContrat) {
        String prefix = "";
        switch(typeContrat) {
            case "CDI": prefix = "CDI"; break;
            case "CDD": prefix = "CDD"; break;
            case "INTERIM": prefix = "INT"; break;
            case "APPRENTISSAGE": prefix = "APP"; break;
            default: prefix = "CT";
        }
        return prefix + "-" + System.currentTimeMillis();
    }

    
    @GetMapping("/rh/employes/sans-contrat")
    public String employesSansContrat(Model model) {
        try {
            List<Employe> employesSansContrat = employeService.findEmployesSansContrat();
            model.addAttribute("employes", employesSansContrat);
            model.addAttribute("titre", "Employés sans contrat");
            return "rh/listeEmploye";
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors du chargement des employés sans contrat");
            return "rh/listeEmploye";
        }
    }
    
    // AJOUTEZ CES MÉTHODES dans votre contrôleur Rh
    @GetMapping("/rh/contrats")
    public String listeContrats(Model model) {
        try {
            List<ContratEmployeView> contrats = contratEmployeViewService.findAll();
            
            model.addAttribute("contrats", contrats);
            
            // Statistiques
            long totalContrats = contrats.size();
            long contratsActifs = contratEmployeViewService.getContratsActifsCount();
            long contratsCDI = contratEmployeViewService.getContratsCDICount();
            
            model.addAttribute("totalContrats", totalContrats);
            model.addAttribute("contratsActifs", contratsActifs);
            model.addAttribute("contratsCDI", contratsCDI);
            
            return "rh/listeContrats";
            
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors du chargement des contrats: " + e.getMessage());
            return "rh/listeContrats";
        }
    }

    @GetMapping("/rh/contrats/employe")
    public String contratsParEmploye(@RequestParam("id_employe") Integer idEmploye, Model model) {
        try {
            List<ContratEmployeView> contrats = contratEmployeViewService.findByIdEmploye(idEmploye);
            
            // Récupérer les infos de base de l'employé depuis le premier contrat
            Optional<Employe> employe = employeService.findById(idEmploye);
            
            model.addAttribute("contrats", contrats);
            model.addAttribute("employe", employe.orElse(null));
            
            return "rh/contratsEmploye";
            
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors du chargement des contrats de l'employé");
            return "redirect:/rh/contrats";
        }
    }

    @GetMapping("/rh/contrats/search")
    public String searchContrats(@RequestParam(value = "recherche", required = false) String recherche, Model model) {
        try {
            List<ContratEmployeView> contrats;
            
            if (recherche != null && !recherche.trim().isEmpty()) {
                contrats = contratEmployeViewService.searchByNomOrPrenom(recherche.trim());
                model.addAttribute("recherche", recherche);
            } else {
                contrats = contratEmployeViewService.findAll();
            }
            
            model.addAttribute("contrats", contrats);
            model.addAttribute("totalContrats", contrats.size());
            model.addAttribute("contratsActifs", contrats.stream().filter(c -> "actif".equals(c.getStatutContrat())).count());
            model.addAttribute("contratsCDI", contrats.stream().filter(c -> "CDI".equals(c.getTypeContrat())).count());
            
            return "rh/listeContrats";
            
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors de la recherche: " + e.getMessage());
            return "rh/listeContrats";
        }
    }

@GetMapping("/rh/fiche-employe")
public String ficheEmploye(@RequestParam("id_employe") Integer idEmploye, Model model) {
    try {
        System.out.println("=== CHARGEMENT FICHE EMPLOYÉ ID: " + idEmploye + " ===");
        
        // ASSURE-TOI qu'une fiche existe pour cet employé
        ficheEmployeService.ensureFicheExists(idEmploye);
        
        Optional<FicheEmployeCompleteView> fiche = ficheEmployeCompleteViewService.findById(idEmploye);
        
        if (fiche.isPresent()) {
            FicheEmployeCompleteView employe = fiche.get();
            System.out.println("=== DONNÉES EMPLOYÉ ===");
            System.out.println("- ID: " + employe.getId());
            System.out.println("- Nom: '" + employe.getNom() + "'");
            System.out.println("- Prénom: '" + employe.getPrenom() + "'");
            System.out.println("- Poste: '" + employe.getPoste() + "'");
            System.out.println("- Email: '" + employe.getMail() + "'");
            System.out.println("- Photo URL: '" + employe.getPhotoUrl() + "'");
            System.out.println("=== FIN DONNÉES ===");
            
            model.addAttribute("employe", employe);
            return "rh/ficheEmploye";
        } else {
            System.out.println("❌ Employé non trouvé ID: " + idEmploye);
            model.addAttribute("error", "Employé non trouvé");
            return "redirect:/rh/employe";
        }
    } catch (Exception e) {
        System.out.println("❌ ERREUR CRITIQUE fiche employé: " + e.getMessage());
        e.printStackTrace();
        model.addAttribute("error", "Erreur: " + e.getMessage());
        return "redirect:/rh/employe";
    }
}

@PostMapping("/rh/fiche-employe/upload-photo")
public String uploadPhoto(@RequestParam("file") MultipartFile file,
                        @RequestParam("id_employe") Integer idEmploye,
                        Model model) {
    try {
        System.out.println("=== UPLOAD DÉBUT ===");
        System.out.println("ID Employé: " + idEmploye);
        System.out.println("Fichier: " + file.getOriginalFilename());
        System.out.println("Taille: " + file.getSize());
        
        if (file.isEmpty()) {
            model.addAttribute("error", "Veuillez sélectionner un fichier");
            return "redirect:/rh/fiche-employe?id_employe=" + idEmploye;
        }

        // Vérifiez le type MIME
        if (!file.getContentType().startsWith("image/")) {
            model.addAttribute("error", "Veuillez sélectionner une image valide");
            return "redirect:/rh/fiche-employe?id_employe=" + idEmploye;
        }

         // CHEMIN CORRIGÉ - utilise le répertoire de classes
        Path uploadDir = Paths.get("src/main/resources/static/uploads/employes");
        if (!Files.exists(uploadDir)) {
            Files.createDirectories(uploadDir);
        }

        // Générer nom fichier avec extension
        String fileName = "photo_" + idEmploye + "_" + System.currentTimeMillis() + 
                        getFileExtension(file.getOriginalFilename());
        
        // Sauvegarder
        Path filePath = uploadDir.resolve(fileName);
        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

        // Mettre à jour BD dans la TABLE fiche_employe
        String photoUrl = "/uploads/employes/" + fileName;
        ficheEmployeService.updatePhoto(idEmploye, photoUrl);

        model.addAttribute("success", "Photo mise à jour avec succès");
        System.out.println("=== UPLOAD RÉUSSI: " + photoUrl);
        
        return "redirect:/rh/fiche-employe?id_employe=" + idEmploye;

    } catch (Exception e) {
        System.out.println("=== ERREUR UPLOAD: " + e.getMessage());
        e.printStackTrace();
        model.addAttribute("error", "Erreur lors de l'upload: " + e.getMessage());
        return "redirect:/rh/fiche-employe?id_employe=" + idEmploye;
    }
}

@GetMapping("/rh/fiches-employes")
public String listeFichesEmployes(Model model) {
    try {
        List<FicheEmployeCompleteView> employes = ficheEmployeCompleteViewService.findAll();
        model.addAttribute("employes", employes);
        return "rh/listeFichesEmployes";
    } catch (Exception e) {
        model.addAttribute("error", "Erreur lors du chargement des fiches employés");
        return "redirect:/rh/employe";
    }
}

// AJOUTEZ CETTE MÉTHODE DANS VOTRE CLASSE
private String getFileExtension(String fileName) {
    if (fileName == null || fileName.isEmpty()) {
        return ".jpg"; // Extension par défaut
    }
    int lastIndex = fileName.lastIndexOf(".");
    return (lastIndex == -1) ? ".jpg" : fileName.substring(lastIndex).toLowerCase();
}

@GetMapping("/rh/contrat/creer")
public String showCreateContratForm(@RequestParam("id_employe") Integer idEmploye, Model model) {
    try {
        System.out.println("=== CRÉATION CONTRAT POUR EMPLOYÉ ID: " + idEmploye + " ===");
        
        // Récupérer l'employé
        Optional<Employe> employeOpt = employeService.findById(idEmploye);
        
        if (employeOpt.isPresent()) {
            Employe employe = employeOpt.get();
            model.addAttribute("employe", employe);
            model.addAttribute("contrat", new Contrat()); // Objet vide pour le formulaire
            
            // Données pour les selects
            model.addAttribute("typesContrat", Arrays.asList("CDI", "CDD", "INTERIM", "APPRENTISSAGE"));
            model.addAttribute("classifications", Arrays.asList("Cadre", "ETAM", "Ouvrier"));
            model.addAttribute("tempsTravail", Arrays.asList("Plein", "Partiel"));
            
            return "rh/creerContrat";
        } else {
            model.addAttribute("error", "Employé non trouvé");
            return "redirect:/rh/employe";
        }
    } catch (Exception e) {
        System.out.println("ERREUR création contrat: " + e.getMessage());
        model.addAttribute("error", "Erreur: " + e.getMessage());
        return "redirect:/rh/employe";
    }
}

@PostMapping("/rh/contrat/save")
public String saveContrat(@ModelAttribute Contrat contrat,
                         @RequestParam("idEmploye") Integer idEmploye,  // Notez le changement de nom !
                         Model model) {
    try {
        System.out.println("=== SAUVEGARDE CONTRAT MANUEL POUR EMPLOYÉ ID: " + idEmploye + " ===");
        System.out.println("Données reçues:");
        System.out.println("- Type: " + contrat.getTypeContrat());
        System.out.println("- Numéro: " + contrat.getNumeroContrat());
        System.out.println("- Date début: " + contrat.getDateDebut());
        System.out.println("- Salaire base: " + contrat.getSalaireBase());
        
        // Vérifier que l'employé existe
        Optional<Employe> employeOpt = employeService.findById(idEmploye);
        if (!employeOpt.isPresent()) {
            System.out.println("❌ Employé non trouvé");
            model.addAttribute("error", "Employé non trouvé");
            return "redirect:/rh/employe";
        }

        Employe employe = employeOpt.get();
        System.out.println("✅ Employé trouvé: " + employe.getPrenom() + " " + employe.getNom());
        
        // Vérifier s'il n'y a pas déjà un contrat actif
        boolean contratActifExiste = contratService.existsContratActifByEmploye(idEmploye);
        if (contratActifExiste) {
            System.out.println("❌ Contrat actif existe déjà");
            model.addAttribute("error", "Cet employé a déjà un contrat actif");
            return "redirect:/rh/fiche-employe?id_employe=" + idEmploye;
        }

        // Configurer le contrat (les champs sont déjà remplis par @ModelAttribute)
        contrat.setIdEmploye(idEmploye);
        contrat.setStatutContrat("actif");
        
        // Générer numéro de contrat si vide
        if (contrat.getNumeroContrat() == null || contrat.getNumeroContrat().isEmpty()) {
            String numeroContrat = genererNumeroContrat(contrat.getTypeContrat());
            contrat.setNumeroContrat(numeroContrat);
            System.out.println("📝 Numéro généré: " + numeroContrat);
        }

        // Calculer automatiquement la date de fin d'essai si période > 0
        if (contrat.getPeriodeEssaiJours() != null && contrat.getPeriodeEssaiJours() > 0 && contrat.getDateDebut() != null) {
            LocalDate dateFinEssai = contrat.getDateDebut().plusDays(contrat.getPeriodeEssaiJours());
            contrat.setDateFinEssai(dateFinEssai);
            System.out.println("📅 Date fin essai calculée: " + dateFinEssai);
        }

        System.out.println("💾 Tentative de sauvegarde...");
        
        // Sauvegarder
        Contrat contratSauvegarde = contratService.save(contrat);
        
        System.out.println("✅ Contrat sauvegardé avec ID: " + contratSauvegarde.getId());
        System.out.println("=== SAUVEGARDE CONTRAT RÉUSSIE ===");
        
        model.addAttribute("success", "Contrat créé avec succès pour " + employe.getPrenom() + " " + employe.getNom());
        
        return "redirect:/rh/fiche-employe?id_employe=" + idEmploye;
        
    } catch (Exception e) {
        System.out.println("❌ ERREUR sauvegarde contrat: " + e.getMessage());
        e.printStackTrace();
        model.addAttribute("error", "Erreur création contrat: " + e.getMessage());
        return "redirect:/rh/contrat/creer?id_employe=" + idEmploye;
    }
}
}
