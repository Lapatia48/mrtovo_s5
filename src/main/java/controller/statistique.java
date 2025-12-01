package controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import service.StatistiqueService;

@Controller
@RequestMapping("/rh/statistiques")
public class statistique {
   
    @Autowired
    private StatistiqueService statistiqueService;
    
    @GetMapping("/dashboard")
    public String showDashboardStatistiques(Model model) {
        try {
            Map<String, Long> effectifDepartement = statistiqueService.getEffectifParDepartement();
            Map<String, Long> effectifAge = statistiqueService.getEffectifParTrancheAge();
            Map<String, Long> effectifContrat = statistiqueService.getEffectifParTypeContrat();
            Double ancienneteMoyenne = statistiqueService.getAncienneteMoyenne();
            
            Long effectifTotal = statistiqueService.getEffectifTotal();
            
            model.addAttribute("effectifDepartement", effectifDepartement);
            model.addAttribute("effectifAge", effectifAge);
            model.addAttribute("effectifContrat", effectifContrat);
            model.addAttribute("ancienneteMoyenne", ancienneteMoyenne);
            model.addAttribute("effectifTotal", effectifTotal);
            
            return "statistique/dashboard";
            
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors du chargement des statistiques: " + e.getMessage());
            return "statistique/dashboard";
        }
    }
    
   @GetMapping("/performance-rh")
    public String showPerformanceRH(Model model) {
        try {
            // ✅ KPI Turnover actuel (12 derniers mois)
            Map<String, Object> turnover = statistiqueService.getTauxTurnover();
            model.addAttribute("turnover", turnover);
            
            // ✅ Absentéisme
            Map<String, Object> absenteisme = statistiqueService.getTauxAbsenteisme();
            model.addAttribute("absenteisme", absenteisme);
            
            // ✅ Détails des absences
            List<Map<String, Object>> detailsAbsences = statistiqueService.getDetailsAbsencesParEmploye();
            model.addAttribute("detailsAbsences", detailsAbsences);
            
            // ✅ HISTORIQUE CORRIGÉ : données complètes pour le graphique
            List<Map<String, Object>> historiqueTurnover = statistiqueService.getHistoriqueTurnover();
            model.addAttribute("historiqueTurnover", historiqueTurnover);
            
            return "statistique/performance";
            
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors du chargement des statistiques de performance RH: " + e.getMessage());
            return "statistique/performance";
        }
    }

    // API pour les données turnover
    @GetMapping("/api/turnover")
    @ResponseBody // 
    public Map<String, Object> getTurnoverData() {
        return statistiqueService.getTauxTurnover();
    }

    // API pour les données absentéisme
    @GetMapping("/api/absenteisme")
    @ResponseBody // 
    public Map<String, Object> getAbsenteismeData() {
        return statistiqueService.getTauxAbsenteisme();
    }

    // API pour l'historique turnover
    @GetMapping("/api/historique-turnover")
    @ResponseBody // 
    public List<Map<String, Object>> getHistoriqueTurnover() {
        return statistiqueService.getHistoriqueTurnover();
    }
}