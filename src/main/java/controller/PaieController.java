package controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestParam;

import service.*;
import entity.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Controller
public class PaieController {

    @Autowired
    private PaieService paieService;

    @Autowired
    private EmployeService employeService;

    @GetMapping("/rh/employe/payer")
    public String formulairePaie(@RequestParam("id_emp") Integer idEmp, Model model) {
        Optional<Employe> employeOpt = employeService.findById(idEmp);
        if (employeOpt.isPresent()) {
            model.addAttribute("employe", employeOpt.get());
            model.addAttribute("idEmp", idEmp);
            return "paie/formulairePaie";
        } else {
            model.addAttribute("error", "Employe non trouve");
            return "redirect:/rh/employe/liste";
        }
    }

@PostMapping("/rh/employe/calculerPaie")
public String calculerPaie(
        @RequestParam("id_emp") Integer idEmploye,
        @RequestParam("periode_debut") String periodeDebut,
        @RequestParam("periode_fin") String periodeFin,
        @RequestParam("heures_sup_normales") BigDecimal heuresSupNormales,
        @RequestParam("heures_sup_weekend") BigDecimal heuresSupWeekend,
        @RequestParam("prime_anciennete") BigDecimal primeAnciennete,
        @RequestParam("absences") BigDecimal absences,
        @RequestParam("autres_primes") BigDecimal autresPrimes,
        @RequestParam("mode_paiement") String modePaiement,
        Model model) {

    Optional<Employe> employeOpt = employeService.findById(idEmploye);
    if (!employeOpt.isPresent()) {
        model.addAttribute("error", "Employe non trouve");
        return "redirect:/rh/employe/liste";
    }

    Employe employe = employeOpt.get();
    
    BigDecimal salaireBase = employe.getSalaire() != null ? 
        new BigDecimal(employe.getSalaire()) : BigDecimal.ZERO;
    
    BigDecimal tauxJournalier = salaireBase.divide(new BigDecimal("30"), 2, BigDecimal.ROUND_HALF_UP);
    BigDecimal tauxHoraire = tauxJournalier.divide(new BigDecimal("8"), 2, BigDecimal.ROUND_HALF_UP);
    
    // Calculs des montants
    BigDecimal montantHeuresSupNormales = heuresSupNormales.multiply(tauxHoraire).multiply(new BigDecimal("1.30"));
    BigDecimal montantHeuresSupWeekend = heuresSupWeekend.multiply(tauxHoraire).multiply(new BigDecimal("1.50"));
    BigDecimal montantAbsences = absences.multiply(tauxHoraire);
    
    // Taux pour l'affichage
    BigDecimal tauxHeuresSup30 = tauxHoraire.multiply(new BigDecimal("1.30"));
    BigDecimal tauxHeuresSup50 = tauxHoraire.multiply(new BigDecimal("1.50"));
    BigDecimal indice = tauxHoraire.multiply(new BigDecimal("5.85"));
    
    BigDecimal salaireBrut = salaireBase
        .add(montantHeuresSupNormales)
        .add(montantHeuresSupWeekend)
        .add(primeAnciennete)
        .add(autresPrimes)
        .subtract(montantAbsences);
    
    // Calcul CNaPS (1% du salaire brut, max 28,000 Ar)
    BigDecimal retenueCnaps = salaireBrut.multiply(new BigDecimal("0.01"));
    if (retenueCnaps.compareTo(new BigDecimal("28000")) > 0) {
        retenueCnaps = new BigDecimal("28000");
    }
    
    BigDecimal retenueOstie = salaireBrut.multiply(new BigDecimal("0.01"));
    
    // Calcul IRSA avec détails des tranches
    Map<String, BigDecimal> irsaDetails = calculerIrsaDetails(salaireBrut);
    BigDecimal retenueIrsa = irsaDetails.get("total");
    
    BigDecimal totalRetenues = retenueCnaps.add(retenueOstie).add(retenueIrsa);
    BigDecimal netAPayer = salaireBrut.subtract(totalRetenues);

    // Preparation des donnees
    model.addAttribute("employe", employe);
    model.addAttribute("salaireBase", salaireBase);
    model.addAttribute("tauxJournalier", tauxJournalier);
    model.addAttribute("tauxHoraire", tauxHoraire);
    model.addAttribute("tauxHeuresSup30", tauxHeuresSup30);
    model.addAttribute("tauxHeuresSup50", tauxHeuresSup50);
    model.addAttribute("indice", indice);
    model.addAttribute("salaireBrut", salaireBrut);
    model.addAttribute("retenueCnaps", retenueCnaps);
    model.addAttribute("retenueOstie", retenueOstie);
    model.addAttribute("retenueIrsa", retenueIrsa);
    model.addAttribute("totalRetenues", totalRetenues);
    model.addAttribute("netAPayer", netAPayer);
    model.addAttribute("modePaiement", modePaiement);
    
    // Détails IRSA
    model.addAttribute("irsaTranche2", irsaDetails.get("tranche2"));
    model.addAttribute("irsaTranche3", irsaDetails.get("tranche3"));
    model.addAttribute("irsaTranche4", irsaDetails.get("tranche4"));
    model.addAttribute("irsaTranche5", irsaDetails.get("tranche5"));
    model.addAttribute("irsaTranche6", irsaDetails.get("tranche6"));
    
    model.addAttribute("periodeDebut", periodeDebut);
    model.addAttribute("periodeFin", periodeFin);
    model.addAttribute("heuresSupNormales", heuresSupNormales);
    model.addAttribute("heuresSupWeekend", heuresSupWeekend);
    model.addAttribute("primeAnciennete", primeAnciennete);
    model.addAttribute("absences", absences);
    model.addAttribute("autresPrimes", autresPrimes);
    model.addAttribute("montantAbsences", montantAbsences);
    model.addAttribute("montantHeuresSupNormales", montantHeuresSupNormales);
    model.addAttribute("montantHeuresSupWeekend", montantHeuresSupWeekend);
    model.addAttribute("idEmp", idEmploye);

    return "paie/confirmationPaie";
}

// Méthode pour calculer l'IRSA avec détails par tranche
private Map<String, BigDecimal> calculerIrsaDetails(BigDecimal salaireBrut) {
    Map<String, BigDecimal> details = new HashMap<>();
    BigDecimal total = BigDecimal.ZERO;
    
    BigDecimal tranche1 = new BigDecimal("350000");
    BigDecimal tranche2 = new BigDecimal("400000");
    BigDecimal tranche3 = new BigDecimal("500000");
    BigDecimal tranche4 = new BigDecimal("600000");
    BigDecimal tranche5 = new BigDecimal("4000000");
    
    BigDecimal irsaTranche2 = BigDecimal.ZERO;
    BigDecimal irsaTranche3 = BigDecimal.ZERO;
    BigDecimal irsaTranche4 = BigDecimal.ZERO;
    BigDecimal irsaTranche5 = BigDecimal.ZERO;
    BigDecimal irsaTranche6 = BigDecimal.ZERO;
    
    // Tranche 2: 350,001 - 400,000 Ar (5%)
    if (salaireBrut.compareTo(tranche1) > 0) {
        BigDecimal montantTranche2 = salaireBrut.min(tranche2).subtract(tranche1);
        if (montantTranche2.compareTo(BigDecimal.ZERO) > 0) {
            irsaTranche2 = montantTranche2.multiply(new BigDecimal("0.05"));
            total = total.add(irsaTranche2);
        }
    }
    
    // Tranche 3: 400,001 - 500,000 Ar (10%)
    if (salaireBrut.compareTo(tranche2) > 0) {
        BigDecimal montantTranche3 = salaireBrut.min(tranche3).subtract(tranche2);
        if (montantTranche3.compareTo(BigDecimal.ZERO) > 0) {
            irsaTranche3 = montantTranche3.multiply(new BigDecimal("0.10"));
            total = total.add(irsaTranche3);
        }
    }
    
    // Tranche 4: 500,001 - 600,000 Ar (15%)
    if (salaireBrut.compareTo(tranche3) > 0) {
        BigDecimal montantTranche4 = salaireBrut.min(tranche4).subtract(tranche3);
        if (montantTranche4.compareTo(BigDecimal.ZERO) > 0) {
            irsaTranche4 = montantTranche4.multiply(new BigDecimal("0.15"));
            total = total.add(irsaTranche4);
        }
    }
    
    // Tranche 5: 600,001 - 4,000,000 Ar (20%)
    if (salaireBrut.compareTo(tranche4) > 0) {
        BigDecimal montantTranche5 = salaireBrut.min(tranche5).subtract(tranche4);
        if (montantTranche5.compareTo(BigDecimal.ZERO) > 0) {
            irsaTranche5 = montantTranche5.multiply(new BigDecimal("0.20"));
            total = total.add(irsaTranche5);
        }
    }
    
    // Tranche 6: Au-dessus de 4,000,000 Ar (25%)
    if (salaireBrut.compareTo(tranche5) > 0) {
        BigDecimal montantTranche6 = salaireBrut.subtract(tranche5);
        irsaTranche6 = montantTranche6.multiply(new BigDecimal("0.25"));
        total = total.add(irsaTranche6);
    }
    
    details.put("tranche2", irsaTranche2);
    details.put("tranche3", irsaTranche3);
    details.put("tranche4", irsaTranche4);
    details.put("tranche5", irsaTranche5);
    details.put("tranche6", irsaTranche6);
    details.put("total", total);
    
    return details;
}

    @PostMapping("/rh/employe/sauvegarderPaie")
    public String sauvegarderPaie(
            @RequestParam("id_emp") Integer idEmploye,
            @RequestParam("periode_debut") String periodeDebut,
            @RequestParam("periode_fin") String periodeFin,
            @RequestParam("heures_sup_normales") BigDecimal heuresSupNormales,
            @RequestParam("heures_sup_weekend") BigDecimal heuresSupWeekend,
            @RequestParam("prime_anciennete") BigDecimal primeAnciennete,
            @RequestParam("absences") BigDecimal absences,
            @RequestParam("autres_primes") BigDecimal autresPrimes,
            @RequestParam("salaire_brut") BigDecimal salaireBrut,
            @RequestParam("net_a_payer") BigDecimal netAPayer,
            @RequestParam("mode_paiement") String modePaiement,
            Model model) {

        Optional<Employe> employeOpt = employeService.findById(idEmploye);
        if (!employeOpt.isPresent()) {
            model.addAttribute("error", "Employe non trouve");
            return "redirect:/rh/employe/liste";
        }

        Employe employe = employeOpt.get();
        
        Paie paie = new Paie();
        paie.setIdEmploye(idEmploye);
        paie.setDatePaie(LocalDate.now());
        paie.setPeriodeDebut(LocalDate.parse(periodeDebut));
        paie.setPeriodeFin(LocalDate.parse(periodeFin));
        paie.setSalaireBase(new BigDecimal(employe.getSalaire()));
        paie.setHeuresSupNormales(heuresSupNormales);
        paie.setHeuresSupWeekend(heuresSupWeekend);
        paie.setPrimeAnciennete(primeAnciennete);
        paie.setAbsences(absences);
        paie.setAutresPrimes(autresPrimes);
        paie.setSalaireBrut(salaireBrut);
        paie.setRetenueCnaps(salaireBrut.multiply(new BigDecimal("0.01")));
        paie.setRetenueOstie(salaireBrut.multiply(new BigDecimal("0.01")));
        paie.setRetenueIrsa(salaireBrut.multiply(new BigDecimal("0.10")));
        paie.setTotalRetenues(paie.getRetenueCnaps().add(paie.getRetenueOstie()).add(paie.getRetenueIrsa()));
        paie.setNetAPayer(netAPayer);
        paie.setModePaiement(modePaiement);

        paieService.save(paie);

        model.addAttribute("success", "Paiement enregistre avec succes pour " + employe.getPrenom() + " " + employe.getNom());
        return "redirect:/rh/employe/liste";
    }
}