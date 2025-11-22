package controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import entity.ContratEmployeView;
import service.CongeeService;
import service.ContratService;
import service.EmployeService;

@Controller
public class statistique {

    @Autowired
    private EmployeService employeService;

    @Autowired
    private ContratService service;

    @Autowired
    private CongeeService congeeService;


    @GetMapping("/statistique/employe")
    public String getStatistiqueEmploye(Model model) {
        List<Object[]> stats = employeService.getBirthYearStats();

        // Extract data for Chart.js
        List<Integer> years = new ArrayList<>();
        List<Long> counts = new ArrayList<>();

        for (Object[] row : stats) {
            if (row[0] == null || row[1] == null) {
                continue;
            }

            years.add(((Number) row[0]).intValue());
            counts.add(((Number) row[1]).longValue());
        }

        model.addAttribute("years", years);
        model.addAttribute("counts", counts);

        List<Object[]> statsDepartement = employeService.countByDepartement();

        List<String> departements = new ArrayList<>();
        List<Long> countsDepartement = new ArrayList<>();

        for (Object[] row : statsDepartement) {
            if (row[0] == null || row[1] == null) continue;

            departements.add((String) row[0]);
            countsDepartement.add(((Number) row[1]).longValue());
        }

        model.addAttribute("departements", departements);
        model.addAttribute("countsDepartements", countsDepartement);

        return "statistique/statistiqueEmploye";
    }

    @GetMapping("/statistique/conge")
    public String getStatistiqueConge() {

        return "statistique/statistiqueConge";
    }

    @GetMapping("/statistique/contrat")
    public String getStatistiqueContrat(Model model) {
        List<ContratEmployeView> list = service.getContractsExpiringInTwoMonths();
        model.addAttribute("contracts", list);

        List<Object[]> leaves = congeeService.getRemainingLeavePerEmployee();
        model.addAttribute("leaves", leaves);

        return "statistique/statistiqueContrat";
    }


}
