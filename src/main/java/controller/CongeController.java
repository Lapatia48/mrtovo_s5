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
import jakarta.transaction.Transactional;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

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
        System.out.println("Nombre de congés en cours: " + congesEnCours.size()); // Debuging
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
}