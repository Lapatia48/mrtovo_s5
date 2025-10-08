package controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.stereotype.Controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entity.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import service.*;
import repository.*;

@Controller
public class admin {

    @Autowired
    private AdminService adminService;


    // traitement login admin
    @GetMapping("/formLogAdmin")
    public String formLogAdmin(Model model) {
        return "admin/formLogAdmin"; 
    }

    @PostMapping("/logAdmin")
    public String logAdmin(
                            @RequestParam("nom") String nom,
                            @RequestParam("motDePasse") String motDePasse,
                            Model model) {
        var optAdmin = adminService.login(nom, motDePasse);
        if (optAdmin.isPresent()) {
            model.addAttribute("admin", optAdmin.get());
            return "admin/accueilAdmin"; 
        } else {
            model.addAttribute("error", "Nom ou mot de passe incorrect.");
            return "admin/formLogAdmin";
        }
    }

}