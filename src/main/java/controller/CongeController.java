package controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.stereotype.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestParam;

import service.*;
import entity.CongeEtat;
import entity.CongeEtatDetails;
import entity.Employe;
import entity.EmployePointage;
import entity.PointageEmploye;
import entity.VueSoldeConges;
import jakarta.transaction.Transactional;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CongeController {

    @Autowired
    private CongeEtatService congeEtatService;

    @Autowired
    private CongeeService congeeService;

    @Autowired
    private CongeEtatDetailsService congeEtatDetailsService;

    @Autowired
    private EmployeService employeService ;

    @Autowired
    private VueSoldeCongesService vueSoldeCongesService;

    @Autowired
    private EmployePointageService employePointageService;

    @Autowired
    private PointageEmployeService pointageEmployeService;

    // traitement demande de congee
    @GetMapping("/rh/employe/demandeConge") 
    public String demandeConge(@RequestParam("id_emp") Long idEmp, Model model) {
        model.addAttribute("idEmp", idEmp);
        return "conge/demandeConge"; 
    }

    @PostMapping("/rh/employe/soumettreDemandeConge")
    public String soumettreDemandeConge(
            @RequestParam("id_emp") Long idEmploye,
            @RequestParam("date_debut") String dateDebut,
            @RequestParam("date_fin") String dateFin,
            Model model) {
        
        try {
            // Conversion des dates
            LocalDate debut = LocalDate.parse(dateDebut);
            LocalDate fin = LocalDate.parse(dateFin);
            LocalDate aujourdhui = LocalDate.now();
            
            // Contrainte 1: date début ne doit pas être dans le passé
            if (debut.isBefore(aujourdhui)) {
                model.addAttribute("error", "Erreur: La date de début est déjà passée");
                model.addAttribute("idEmp", idEmploye); // AJOUT
                return "conge/demandeConge";
            }

            // Vérifier si l'employé a déjà un congé en attente
            List<CongeEtat> congesEnAttente = congeEtatService.findByIdEmployeAndStatutEnAttente(idEmploye.intValue());
            if (!congesEnAttente.isEmpty()) {
                model.addAttribute("error", "Erreur: Vous avez déjà une demande de congé en attente de validation");
                model.addAttribute("idEmp", idEmploye);
                return "conge/demandeConge";
            }
            
            // Contrainte 2: date fin ne doit pas être avant date début
            if (fin.isBefore(debut)) {
                model.addAttribute("error", "Erreur: Vérifier les dates, dates incohérentes");
                model.addAttribute("idEmp", idEmploye); // AJOUT
                return "conge/demandeConge";
            }
            
            int duree = (int) ChronoUnit.DAYS.between(debut, fin) + 1;
            
            // Contrainte 3: Vérification des quotas sur années multiples si nécessaire
            int anneeDebut = debut.getYear();
            int anneeFin = fin.getYear();
            
            if (anneeDebut == anneeFin) {
                // Même année - vérifier quota simple
                Integer quotaRestant = congeeService.getQuotaRestant(idEmploye.intValue(), anneeDebut);
                if (quotaRestant == null || duree > quotaRestant) {
                    model.addAttribute("error", "Erreur: Durée (" + duree + " jours) dépasse le quota restant (" + quotaRestant + " jours) pour " + anneeDebut);
                    model.addAttribute("idEmp", idEmploye); // AJOUT
                    return "conge/demandeConge";
                }
            } else {
                // Congé à cheval sur deux années - vérifier quotas multiples
                LocalDate finAnneeDebut = LocalDate.of(anneeDebut, 12, 31);
                int dureeAnneeDebut = (int) ChronoUnit.DAYS.between(debut, finAnneeDebut) + 1;
                int dureeAnneeFin = (int) ChronoUnit.DAYS.between(LocalDate.of(anneeFin, 1, 1), fin) + 1;
                
                Integer quotaRestantAnneeDebut = congeeService.getQuotaRestant(idEmploye.intValue(), anneeDebut);
                Integer quotaRestantAnneeFin = congeeService.getQuotaRestant(idEmploye.intValue(), anneeFin);
                
                if (quotaRestantAnneeDebut == null || quotaRestantAnneeFin == null) {
                    model.addAttribute("error", "Erreur: Quota non défini pour l'employé");
                    model.addAttribute("idEmp", idEmploye); // AJOUT
                    return "conge/demandeConge";
                }
                
                if (dureeAnneeDebut > quotaRestantAnneeDebut || dureeAnneeFin > quotaRestantAnneeFin) {
                    model.addAttribute("error", "Erreur: Durée dépasse les quotas disponibles (" + 
                        quotaRestantAnneeDebut + " jours en " + anneeDebut + " et " + 
                        quotaRestantAnneeFin + " jours en " + anneeFin + ")");
                    model.addAttribute("idEmp", idEmploye); // AJOUT
                    return "conge/demandeConge";
                }
            }
            
            // Création et sauvegarde de la demande de congé
            CongeEtat congeEtat = new CongeEtat();
            congeEtat.setIdEmploye(idEmploye.intValue());
            congeEtat.setDateDebut(debut);
            congeEtat.setDateFin(fin);
            congeEtat.setDuree(duree);
            congeEtat.setDateDemande(aujourdhui);
            congeEtat.setDateValidation(null);
            congeEtat.setStatut("en_attente");
            
            congeEtatService.save(congeEtat);
            
            
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors du traitement: " + e.getMessage());
            model.addAttribute("idEmp", idEmploye); // AJOUT
            return "conge/demandeConge";
        }
        
        List<Employe> employes = employeService.findAll();
        model.addAttribute("employes", employes);
        return "rh/listeEmploye"; 
    }

    @GetMapping("/rh/conge/attente")
    public String listeCongesEnAttente(Model model) {
        List<CongeEtatDetails> congesEnAttente = congeEtatDetailsService.findAllEnAttente();
        model.addAttribute("congesEnAttente", congesEnAttente);
        return "conge/congeEnAttente";
    }

    @GetMapping("/rh/conge/enCours")
    public String listeCongesEnCours(Model model) {
        List<CongeEtatDetails> congesEnCours = congeEtatDetailsService.findAllEnCoursGeneral();
        System.out.println("Nombre de congés en cours: " + congesEnCours.size()); // Debug
        model.addAttribute("congesEnCours", congesEnCours);
        return "conge/congeEnCours";
    }

    @GetMapping("/rh/conge/refuse")
    public String listeCongesRefuses(Model model) {
        List<CongeEtatDetails> congesRefuses = congeEtatDetailsService.findAllRefuses();
        model.addAttribute("congesRefuses", congesRefuses);
        return "conge/congeRefuse";
    }

    @GetMapping("/rh/conge/historique")
    public String historiqueConges(Model model) {
        List<CongeEtatDetails> historiqueConges = congeEtatDetailsService.findAll();
        model.addAttribute("historiqueConges", historiqueConges);
        return "conge/historiqueConge";
    }

    @Transactional
    @GetMapping("/rh/conge/valider")
    public String validerConge(@RequestParam("id") Integer idConge) {
        CongeEtat congeEtat = congeEtatService.findById(idConge);
        if (congeEtat != null) {
            congeEtat.setStatut("approuve");
            congeEtat.setDateValidation(LocalDate.now());
            congeEtatService.save(congeEtat);
            // Mise à jour du quota
            congeeService.updateQuota(congeEtat.getIdEmploye(), congeEtat.getDuree());
        }
        return "redirect:/rh/conge/attente";
    }

    @GetMapping("/rh/conge/refuser")
    public String refuserConge(@RequestParam("id") Integer idConge) {
        CongeEtat congeEtat = congeEtatService.findById(idConge);
        if (congeEtat != null) {
            congeEtat.setStatut("refuse");
            congeEtat.setDateValidation(LocalDate.now());
            congeEtatService.save(congeEtat);
        }
        return "redirect:/rh/conge/attente";
    }


    @GetMapping("/rh/conge/list")
    public String listeSoldesConges(
            @RequestParam(value = "annee", required = false) Integer annee,
            @RequestParam(value = "departement", required = false) String departement,
            @RequestParam(value = "showNegatifs", required = false) Boolean showNegatifs,
            Model model) {
        
        try {
            List<VueSoldeConges> soldesConges;
            String filtreActif = "Tous les employés";
            
            // Appliquer les filtres
            if (showNegatifs != null && showNegatifs) {
                soldesConges = vueSoldeCongesService.findSoldesNegatifs();
                filtreActif = "Soldes négatifs seulement";
            } else if (annee != null && departement != null && !departement.isEmpty()) {
                soldesConges = vueSoldeCongesService.findByAnneeAndDepartement(annee, departement);
                filtreActif = String.format("Département %s - Année %d", departement, annee);
                model.addAttribute("filtreAnnee", annee);
                model.addAttribute("filtreDepartement", departement);
            } else if (annee != null) {
                soldesConges = vueSoldeCongesService.findByAnnee(annee);
                filtreActif = String.format("Année %d", annee);
                model.addAttribute("filtreAnnee", annee);
            } else if (departement != null && !departement.isEmpty()) {
                soldesConges = vueSoldeCongesService.findByDepartement(departement);
                filtreActif = String.format("Département %s", departement);
                model.addAttribute("filtreDepartement", departement);
            } else {
                soldesConges = vueSoldeCongesService.findAll();
            }
            
            // Compter les soldes négatifs
            long nbNegatifs = soldesConges.stream().filter(VueSoldeConges::isSoldeNegatif).count();
            
            // Ajouter les attributs au modèle
            model.addAttribute("soldesConges", soldesConges);
            model.addAttribute("filtreActif", filtreActif);
            model.addAttribute("nbNegatifs", nbNegatifs);
            model.addAttribute("statistiques", vueSoldeCongesService.getStatistiques());
            model.addAttribute("totalEmployes", soldesConges.size());
            
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors de la récupération des soldes: " + e.getMessage());
        }
        
        return "conge/congeListe";
    }
    
    @GetMapping("/rh/conge/solde-negatifs")
    public String listeSoldesNegatifs(Model model) {
        try {
            List<VueSoldeConges> soldesNegatifs = vueSoldeCongesService.findSoldesNegatifs();
            model.addAttribute("soldesConges", soldesNegatifs);
            model.addAttribute("filtreActif", "Soldes négatifs");
            model.addAttribute("nbNegatifs", soldesNegatifs.size());
            model.addAttribute("totalEmployes", soldesNegatifs.size());
        } catch (Exception e) {
            model.addAttribute("error", "Erreur: " + e.getMessage());
        }
        return "conge/congeListe";
    }
    
    @GetMapping("/employe/mon-solde")
    public String monSoldeConge(@RequestParam("id_emp") Integer employeId, Model model) {
        try {
            VueSoldeConges monSolde = vueSoldeCongesService.findByEmployeId(employeId);
            if (monSolde != null) {
                model.addAttribute("solde", monSolde);
            } else {
                model.addAttribute("error", "Aucun solde de congé trouvé pour cet employé");
            }
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors de la récupération de votre solde: " + e.getMessage());
        }
        return "conge/monSoldeConge";
    }

    @GetMapping("/rh/conge/pointage")
    public String listeEmployesPointage(
            @RequestParam(value = "departement", required = false) String departement,
            @RequestParam(value = "recherche", required = false) String recherche,
            Model model) {
        
        try {
            List<EmployePointage> employes;
            String filtreActif = "Tous les employés";
            
            if (recherche != null && !recherche.trim().isEmpty()) {
                employes = employePointageService.searchByNomOrPrenom(recherche);
                filtreActif = "Recherche: " + recherche;
                model.addAttribute("recherche", recherche);
            } else if (departement != null && !departement.isEmpty()) {
                employes = employePointageService.findByDepartement(departement);
                filtreActif = "Département: " + departement;
                model.addAttribute("departement", departement);
            } else {
                employes = employePointageService.findAll();
            }
            
            // Ajouter les statistiques
            model.addAttribute("employes", employes);
            model.addAttribute("filtreActif", filtreActif);
            model.addAttribute("totalEmployes", employes.size());
            model.addAttribute("statistiquesDepartement", employePointageService.getStatistiquesDepartement());
            
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors du chargement des employés: " + e.getMessage());
        }
        
        return "conge/listeEmployesPointage";
    }

    

     // GET - Afficher le formulaire de pointage
    @GetMapping("/rh/conge/formulaire")
    public String formulairePointage(
            @RequestParam("employeId") Integer employeId,
            @RequestParam("type") String type,
            Model model) {
        
        try {
            // Récupérer les infos de l'employé
            EmployePointage employe = employePointageService.findById(employeId);
            
            if (employe == null) {
                model.addAttribute("error", "Employé non trouvé");
                return "redirect:/rh/conge/pointage";
            }
            
            // Préparer les données pour le formulaire
            model.addAttribute("employe", employe);
            model.addAttribute("typeEvenement", type);
            model.addAttribute("aujourdhui", LocalDate.now());
            
            // SUPPRIMER cette partie - on gère dans le JSP
            // Map<String, String> configType = getConfigType(type);
            // model.addAttribute("configType", configType);
            
        } catch (Exception e) {
            model.addAttribute("error", "Erreur: " + e.getMessage());
            return "redirect:/rh/conge/pointage";
        }
        
        return "conge/formulairePointage";
    }

    // POST - Traiter la soumission du formulaire
    @PostMapping("/rh/conge/pointage/sauvegarder")
    public String sauvegarderPointage(
            @RequestParam("employeId") Integer employeId,
            @RequestParam("typeEvenement") String typeEvenement,
            @RequestParam("sousType") String sousType,
            @RequestParam("dateEvenement") String dateEvenement,
            @RequestParam(value = "dureeJours", required = false) Double dureeJours,
            @RequestParam(value = "heuresRetard", required = false) Integer heuresRetard,
            @RequestParam(value = "minutesRetard", required = false) Integer minutesRetard,
            @RequestParam("motif") String motif,
            Model model) {
        
        try {
            // Créer et sauvegarder le pointage
            PointageEmploye pointage = pointageEmployeService.creerPointage(
                employeId, typeEvenement, sousType, dateEvenement, 
                dureeJours, heuresRetard, minutesRetard, motif
            );
            
            // Message de succès avec l'impact
            String impactMessage = "";
            if (pointage.getImpactAnnuel() != null && pointage.getImpactAnnuel() > 0) {
                impactMessage = pointage.getImpactAnnuel() + " jour(s) sur quota annuel";
            } else if (pointage.getImpactExceptionnel() != null && pointage.getImpactExceptionnel() > 0) {
                impactMessage = pointage.getImpactExceptionnel() + " jour(s) sur quota exceptionnel";
            }
            
            model.addAttribute("success", "Pointage enregistré avec succès! Impact: " + impactMessage);
                
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors de l'enregistrement: " + e.getMessage());
        }
        
        return "redirect:/rh/conge/pointage";
    }
}