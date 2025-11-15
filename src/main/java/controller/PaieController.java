package controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestParam;

import service.*;
import entity.*;
import jakarta.servlet.http.HttpServletResponse;
import repository.CongeeRepository;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;



@Controller
public class PaieController {

    @Autowired
    private PaieService paieService;

    @Autowired
    private EmployeService employeService;
    
    @Autowired
    private CongeeRepository congeeRepository;

    @GetMapping("/rh/paie/list")
    public String listePaies(Model model) {
        List<Paie> listePaies = paieService.findAll();
        model.addAttribute("listePaies", listePaies);
        return "paie/historiquePaie";
    }

    @GetMapping("/rh/employe/payer")
    public String formulairePaie(@RequestParam("id_emp") Integer idEmp, Model model) {
        Optional<Employe> employeOpt = employeService.findById(idEmp);
        if (employeOpt.isPresent()) {
            Integer quotaConge = getQuotaAnnuel(idEmp);
            model.addAttribute("quotaConge", quotaConge != null ? quotaConge : 0);

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

    @PostMapping("/rh/employe/exporterExcel")
    public void exporterExcel(
            @RequestParam("id_emp") Integer idEmploye,
            @RequestParam("periode_debut") String periodeDebut,
            @RequestParam("periode_fin") String periodeFin,
            @RequestParam("salaire_base") BigDecimal salaireBase,
            @RequestParam("taux_journalier") BigDecimal tauxJournalier,
            @RequestParam("taux_horaire") BigDecimal tauxHoraire,
            @RequestParam("heures_sup_normales") BigDecimal heuresSupNormales,
            @RequestParam("heures_sup_weekend") BigDecimal heuresSupWeekend,
            @RequestParam("prime_anciennete") BigDecimal primeAnciennete,
            @RequestParam("absences") BigDecimal absences,
            @RequestParam("autres_primes") BigDecimal autresPrimes,
            @RequestParam("salaire_brut") BigDecimal salaireBrut,
            @RequestParam("retenue_cnaps") BigDecimal retenueCnaps,
            @RequestParam("retenue_ostie") BigDecimal retenueOstie,
            @RequestParam("retenue_irsa") BigDecimal retenueIrsa,
            @RequestParam("total_retenues") BigDecimal totalRetenues,
            @RequestParam("net_a_payer") BigDecimal netAPayer,
            @RequestParam("mode_paiement") String modePaiement,
            @RequestParam("nom_employe") String nomEmploye,
            @RequestParam("prenom_employe") String prenomEmploye,
            @RequestParam("poste_employe") String posteEmploye,
            @RequestParam("date_embauche") String dateEmbauche,
            HttpServletResponse response) throws IOException {

        // Configuration de la réponse pour un fichier Excel
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment; filename=fiche_paie_" + nomEmploye + "_" + prenomEmploye + "_" + periodeFin + ".xls");
        
        // Création du workbook Excel
        try (Workbook workbook = new HSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Fiche de Paie");
            
            // Style pour les titres
            CellStyle titleStyle = workbook.createCellStyle();
            Font titleFont = workbook.createFont();
            titleFont.setBold(true);
            titleFont.setFontHeightInPoints((short) 14);
            titleStyle.setFont(titleFont);
            
            // Style pour les en-têtes
            CellStyle headerStyle = workbook.createCellStyle();
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerStyle.setFont(headerFont);
            headerStyle.setBorderBottom(BorderStyle.THIN);
            
            // Style pour les montants
            CellStyle amountStyle = workbook.createCellStyle();
            amountStyle.setDataFormat(workbook.createDataFormat().getFormat("#,##0.00"));
            
            int rowNum = 0;
            
            // Titre principal
            Row titleRow = sheet.createRow(rowNum++);
            Cell titleCell = titleRow.createCell(0);
            titleCell.setCellValue("FICHE DE PAIE");
            titleCell.setCellStyle(titleStyle);
            
            // Date d'arrêté
            Row dateRow = sheet.createRow(rowNum++);
            dateRow.createCell(0).setCellValue("ARRETE AU " + periodeFin);
            
            rowNum++; // Ligne vide
            
            // Informations employé
            Row infoRow1 = sheet.createRow(rowNum++);
            infoRow1.createCell(0).setCellValue("Nom et Prénoms :");
            infoRow1.createCell(1).setCellValue(nomEmploye + " " + prenomEmploye);
            infoRow1.createCell(2).setCellValue("Classification :");
            infoRow1.createCell(3).setCellValue("HC");
            
            Row infoRow2 = sheet.createRow(rowNum++);
            infoRow2.createCell(0).setCellValue("Matricule :");
            infoRow2.createCell(1).setCellValue(idEmploye + "/TNR");
            infoRow2.createCell(2).setCellValue("Salaire de base :");
            infoRow2.createCell(3).setCellValue(salaireBase.doubleValue());
            
            Row infoRow3 = sheet.createRow(rowNum++);
            infoRow3.createCell(0).setCellValue("Fonction :");
            infoRow3.createCell(1).setCellValue(posteEmploye);
            infoRow3.createCell(2).setCellValue("Taux journaliers :");
            infoRow3.createCell(3).setCellValue(tauxJournalier.doubleValue());
            
            Row infoRow4 = sheet.createRow(rowNum++);
            infoRow4.createCell(0).setCellValue("N° CNaPS :");
            infoRow4.createCell(1).setCellValue("345670000");
            infoRow4.createCell(2).setCellValue("Taux horaires :");
            infoRow4.createCell(3).setCellValue(tauxHoraire.doubleValue());
            
            Row infoRow5 = sheet.createRow(rowNum++);
            infoRow5.createCell(0).setCellValue("Date d'embauche :");
            infoRow5.createCell(1).setCellValue(dateEmbauche);
            infoRow5.createCell(2).setCellValue("Indice :");
            infoRow5.createCell(3).setCellValue(tauxHoraire.multiply(new BigDecimal("5.85")).doubleValue());
            
            rowNum++; // Ligne vide
            
            // En-tête du tableau des éléments
            Row headerRow = sheet.createRow(rowNum++);
            String[] headers = {"Désignations", "Nombre", "Taux", "Montant"};
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
            }
            
            // Éléments de paie
            Row salaireRow = sheet.createRow(rowNum++);
            salaireRow.createCell(0).setCellValue("Salaire du " + periodeDebut + " au " + periodeFin);
            salaireRow.createCell(1).setCellValue("1 mois");
            salaireRow.createCell(2).setCellValue(tauxJournalier.doubleValue());
            salaireRow.createCell(3).setCellValue(salaireBase.doubleValue());
            
            Row absenceRow = sheet.createRow(rowNum++);
            absenceRow.createCell(0).setCellValue("Absences déductibles");
            absenceRow.createCell(1).setCellValue(absences.doubleValue() + " h");
            absenceRow.createCell(2).setCellValue(tauxHoraire.doubleValue());
            absenceRow.createCell(3).setCellValue(-absences.multiply(tauxHoraire).doubleValue());
            
            Row primeAncienRow = sheet.createRow(rowNum++);
            primeAncienRow.createCell(0).setCellValue("Primes d'ancienneté");
            primeAncienRow.createCell(1).setCellValue("");
            primeAncienRow.createCell(2).setCellValue(primeAnciennete.doubleValue());
            primeAncienRow.createCell(3).setCellValue(primeAnciennete.doubleValue());
            
            Row heureSup30Row = sheet.createRow(rowNum++);
            heureSup30Row.createCell(0).setCellValue("Heures supplémentaires majorées de 30%");
            heureSup30Row.createCell(1).setCellValue(heuresSupNormales.doubleValue() + " h");
            heureSup30Row.createCell(2).setCellValue(tauxHoraire.multiply(new BigDecimal("1.30")).doubleValue());
            heureSup30Row.createCell(3).setCellValue(heuresSupNormales.multiply(tauxHoraire).multiply(new BigDecimal("1.30")).doubleValue());
            
            Row heureSup50Row = sheet.createRow(rowNum++);
            heureSup50Row.createCell(0).setCellValue("Heures supplémentaires majorées de 50%");
            heureSup50Row.createCell(1).setCellValue(heuresSupWeekend.doubleValue() + " h");
            heureSup50Row.createCell(2).setCellValue(tauxHoraire.multiply(new BigDecimal("1.50")).doubleValue());
            heureSup50Row.createCell(3).setCellValue(heuresSupWeekend.multiply(tauxHoraire).multiply(new BigDecimal("1.50")).doubleValue());
            
            Row primeDiversRow = sheet.createRow(rowNum++);
            primeDiversRow.createCell(0).setCellValue("Primes diverses");
            primeDiversRow.createCell(1).setCellValue("");
            primeDiversRow.createCell(2).setCellValue(autresPrimes.doubleValue());
            primeDiversRow.createCell(3).setCellValue(autresPrimes.doubleValue());
            
            // Total A
            Row totalARow = sheet.createRow(rowNum++);
            totalARow.createCell(2).setCellValue("A");
            totalARow.createCell(3).setCellValue(salaireBrut.doubleValue());
            
            // Salaire brut
            Row salaireBrutRow = sheet.createRow(rowNum++);
            salaireBrutRow.createCell(0).setCellValue("Salaire brut");
            salaireBrutRow.createCell(3).setCellValue(salaireBrut.doubleValue());
            salaireBrutRow.getCell(0).setCellStyle(headerStyle);
            salaireBrutRow.getCell(3).setCellStyle(headerStyle);
            
            rowNum++; // Ligne vide
            
            // Retenues
            Row cnapsRow = sheet.createRow(rowNum++);
            cnapsRow.createCell(0).setCellValue("Retenue CNaPS 1%");
            cnapsRow.createCell(2).setCellValue(retenueCnaps.doubleValue());
            
            Row ostieRow = sheet.createRow(rowNum++);
            ostieRow.createCell(0).setCellValue("Retenue sanitaire");
            ostieRow.createCell(2).setCellValue(retenueOstie.doubleValue());
            
            // IRSA détaillé
            sheet.createRow(rowNum++).createCell(0).setCellValue("Tranche IRSA INF 350 000");
            
            Map<String, BigDecimal> irsaDetails = calculerIrsaDetails(salaireBrut);
            
            Row irsa2Row = sheet.createRow(rowNum++);
            irsa2Row.createCell(0).setCellValue("Tranche IRSA DE 350 001 à 400 000");
            irsa2Row.createCell(1).setCellValue("5%");
            irsa2Row.createCell(2).setCellValue(irsaDetails.get("tranche2").doubleValue());
            
            Row irsa3Row = sheet.createRow(rowNum++);
            irsa3Row.createCell(0).setCellValue("Tranche IRSA DE 400 001 à 500 000");
            irsa3Row.createCell(1).setCellValue("10%");
            irsa3Row.createCell(2).setCellValue(irsaDetails.get("tranche3").doubleValue());
            
            Row irsa4Row = sheet.createRow(rowNum++);
            irsa4Row.createCell(0).setCellValue("Tranche IRSA DE 500 001 à 600 000");
            irsa4Row.createCell(1).setCellValue("15%");
            irsa4Row.createCell(2).setCellValue(irsaDetails.get("tranche4").doubleValue());
            
            Row irsa5Row = sheet.createRow(rowNum++);
            irsa5Row.createCell(0).setCellValue("Tranche IRSA DE 600 001 à 4000 000");
            irsa5Row.createCell(1).setCellValue("20%");
            irsa5Row.createCell(2).setCellValue(irsaDetails.get("tranche5").doubleValue());
            
            Row irsa6Row = sheet.createRow(rowNum++);
            irsa6Row.createCell(0).setCellValue("Tranche IRSA PLUS DE 4000 000");
            irsa6Row.createCell(1).setCellValue("25%");
            irsa6Row.createCell(2).setCellValue(irsaDetails.get("tranche6").doubleValue());
            
            // Total IRSA
            Row totalIrsaRow = sheet.createRow(rowNum++);
            totalIrsaRow.createCell(0).setCellValue("TOTAL IRSA");
            totalIrsaRow.createCell(2).setCellValue(retenueIrsa.doubleValue());
            totalIrsaRow.getCell(0).setCellStyle(headerStyle);
            
            // Total retenues
            Row totalRetenuesRow = sheet.createRow(rowNum++);
            totalRetenuesRow.createCell(0).setCellValue("Total des retenues");
            totalRetenuesRow.createCell(2).setCellValue(totalRetenues.doubleValue());
            totalRetenuesRow.getCell(0).setCellStyle(headerStyle);
            
            // Net à payer
            Row netRow = sheet.createRow(rowNum++);
            netRow.createCell(0).setCellValue("Net à payer");
            netRow.createCell(2).setCellValue(netAPayer.doubleValue());
            netRow.getCell(0).setCellStyle(headerStyle);
            netRow.getCell(2).setCellStyle(headerStyle);
            
            // Mode de paiement
            Row modeRow = sheet.createRow(rowNum++);
            modeRow.createCell(0).setCellValue("Mode de paiement :");
            modeRow.createCell(1).setCellValue(modePaiement);
            
            // Ajustement automatique des colonnes
            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
            }
            
            // Écriture du workbook dans la réponse
            workbook.write(response.getOutputStream());
        }
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
        return "redirect:/rh/paie/preavis";
    }

    @GetMapping("/rh/paie/preavis")
    public String pagePreavis(Model model) {

        List<Employe> employes = employeService.findAll();
        model.addAttribute("employes", employes);
        return "paie/demande-preavis";
    }

    
    // Ajouter ces méthodes dans PaieController
    @GetMapping("/rh/paie/formPreavis")
    public String formulairePreavis(@RequestParam("id_employe") Integer idEmploye, Model model) {
        Optional<Employe> employeOpt = employeService.findById(idEmploye);
        if (employeOpt.isPresent()) {
            Employe employe = employeOpt.get();
            
            // Récupérer le quota de congé restant
            Integer quotaConge = getQuotaAnnuel(idEmploye);
            
            model.addAttribute("employe", employe);
            model.addAttribute("quotaConge", quotaConge != null ? quotaConge : 0);
            return "paie/form-preavis";
        } else {
            model.addAttribute("error", "Employé non trouvé");
            return "redirect:/rh/employe/liste";
        }
    }

    @PostMapping("/rh/paie/calculerPreavis")
    public String calculerPreavis(
            @RequestParam("id_emp") Integer idEmploye,
            @RequestParam("motif") String motif,
            @RequestParam("duree_preavis") Integer dureePreavis,
            @RequestParam("quota_conge") Integer quotaConge,
            Model model) {

        Optional<Employe> employeOpt = employeService.findById(idEmploye);
        if (!employeOpt.isPresent()) {
            model.addAttribute("error", "Employé non trouvé");
            return "redirect:/rh/employe/liste";
        }

        Employe employe = employeOpt.get();
        
        BigDecimal salaireBase = employe.getSalaire() != null ? 
            new BigDecimal(employe.getSalaire()) : BigDecimal.ZERO;
        
        // Calcul du préavis
        BigDecimal montantPreavis = salaireBase.multiply(new BigDecimal(dureePreavis));
        
        // Calcul des congés payés
        BigDecimal tauxJournalier = salaireBase.divide(new BigDecimal("30"), 2, BigDecimal.ROUND_HALF_UP);
        BigDecimal tauxHoraire = tauxJournalier.divide(new BigDecimal("8"), 2, BigDecimal.ROUND_HALF_UP);
        BigDecimal montantConges = tauxJournalier.multiply(new BigDecimal(quotaConge));
        
        BigDecimal totalBrut;
        BigDecimal netAPayer;
        
        if ("renvoi".equals(motif)) {
            // En cas de renvoi : préavis + congés payés
            totalBrut = montantPreavis.add(montantConges);
            
            // Calcul CNaPS (1% du total brut, max 28,000 Ar)
            BigDecimal retenueCnaps = totalBrut.multiply(new BigDecimal("0.01"));
            if (retenueCnaps.compareTo(new BigDecimal("28000")) > 0) {
                retenueCnaps = new BigDecimal("28000");
            }
            
            BigDecimal retenueOstie = totalBrut.multiply(new BigDecimal("0.01"));
            
            // Calcul IRSA avec détails des tranches (MÊME MÉTHODE QUE PAIE NORMALE)
            Map<String, BigDecimal> irsaDetails = calculerIrsaDetails(totalBrut);
            BigDecimal retenueIrsa = irsaDetails.get("total");
            
            BigDecimal totalRetenues = retenueCnaps.add(retenueOstie).add(retenueIrsa);
            netAPayer = totalBrut.subtract(totalRetenues);
            
            // Préparation des données pour l'affichage détaillé
            model.addAttribute("retenueCnaps", retenueCnaps);
            model.addAttribute("retenueOstie", retenueOstie);
            model.addAttribute("retenueIrsa", retenueIrsa);
            model.addAttribute("totalRetenues", totalRetenues);
            
            // Détails IRSA pour l'affichage
            model.addAttribute("irsaTranche2", irsaDetails.get("tranche2"));
            model.addAttribute("irsaTranche3", irsaDetails.get("tranche3"));
            model.addAttribute("irsaTranche4", irsaDetails.get("tranche4"));
            model.addAttribute("irsaTranche5", irsaDetails.get("tranche5"));
            model.addAttribute("irsaTranche6", irsaDetails.get("tranche6"));
            
        } else {
            // En cas de démission : préavis dû par l'employé - congés payés dus par l'entreprise
            totalBrut = montantPreavis.subtract(montantConges);
            if (totalBrut.compareTo(BigDecimal.ZERO) > 0) {
                // L'employé doit de l'argent
                netAPayer = totalBrut.negate();
            } else {
                // L'entreprise doit de l'argent
                netAPayer = totalBrut.abs();
            }
            
            // Pas de retenues pour les démissions
            model.addAttribute("retenueCnaps", BigDecimal.ZERO);
            model.addAttribute("retenueOstie", BigDecimal.ZERO);
            model.addAttribute("retenueIrsa", BigDecimal.ZERO);
            model.addAttribute("totalRetenues", BigDecimal.ZERO);
            model.addAttribute("irsaTranche2", BigDecimal.ZERO);
            model.addAttribute("irsaTranche3", BigDecimal.ZERO);
            model.addAttribute("irsaTranche4", BigDecimal.ZERO);
            model.addAttribute("irsaTranche5", BigDecimal.ZERO);
            model.addAttribute("irsaTranche6", BigDecimal.ZERO);
        }
        
        model.addAttribute("employe", employe);
        model.addAttribute("motif", motif);
        model.addAttribute("dureePreavis", dureePreavis);
        model.addAttribute("quotaConge", quotaConge);
        model.addAttribute("salaireBase", salaireBase);
        model.addAttribute("tauxJournalier", tauxJournalier);
        model.addAttribute("tauxHoraire", tauxHoraire);
        model.addAttribute("montantPreavis", montantPreavis);
        model.addAttribute("montantConges", montantConges);
        model.addAttribute("totalBrut", totalBrut);
        model.addAttribute("netAPayer", netAPayer);
        
        return "paie/resultat-preavis";
    }

    // Méthode pour récupérer le quota de congé restant
    private Integer getQuotaAnnuel(Integer idEmploye) {
        try {
            Integer anneeCourante = LocalDate.now().getYear();
            Congee congee = congeeRepository.findByIdEmployeAndAnnee(idEmploye, anneeCourante);
            return congee != null ? congee.getQuota() : 30; // 30 jours par défaut si non trouvé
        } catch (Exception e) {
            return 30; // Valeur par défaut
        }
    }   
}