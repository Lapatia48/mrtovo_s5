package entity;

import jakarta.persistence.*;
import org.hibernate.annotations.Immutable;

@Entity
@Immutable
@Table(name = "vue_solde_conges")
public class VueSoldeConges {
    
    @Id
    @Column(name = "employe_id")
    private Integer employeId;
    
    @Column(name = "nom")
    private String nom;
    
    @Column(name = "prenom")
    private String prenom;
    
    @Column(name = "departement")
    private String departement;
    
    @Column(name = "annee")
    private Integer annee;
    
    @Column(name = "quota_annuel_initial")
    private Integer quotaAnnuelInitial;
    
    @Column(name = "quota_exceptionnel_initial")
    private Integer quotaExceptionnelInitial;
    
    @Column(name = "conges_annuel_pris")
    private Integer congesAnnuelPris;
    
    @Column(name = "conges_exceptionnel_pris")
    private Integer congesExceptionnelPris;
    
    @Column(name = "solde_annuel")
    private Integer soldeAnnuel;
    
    @Column(name = "solde_exceptionnel")
    private Integer soldeExceptionnel;
    
    @Column(name = "solde_total")
    private Integer soldeTotal;

    // Constructeurs
    public VueSoldeConges() {}

    // Getters et Setters
    public Integer getEmployeId() { return employeId; }
    public void setEmployeId(Integer employeId) { this.employeId = employeId; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }

    public String getDepartement() { return departement; }
    public void setDepartement(String departement) { this.departement = departement; }

    public Integer getAnnee() { return annee; }
    public void setAnnee(Integer annee) { this.annee = annee; }

    public Integer getQuotaAnnuelInitial() { return quotaAnnuelInitial; }
    public void setQuotaAnnuelInitial(Integer quotaAnnuelInitial) { this.quotaAnnuelInitial = quotaAnnuelInitial; }

    public Integer getQuotaExceptionnelInitial() { return quotaExceptionnelInitial; }
    public void setQuotaExceptionnelInitial(Integer quotaExceptionnelInitial) { this.quotaExceptionnelInitial = quotaExceptionnelInitial; }

    public Integer getCongesAnnuelPris() { return congesAnnuelPris; }
    public void setCongesAnnuelPris(Integer congesAnnuelPris) { this.congesAnnuelPris = congesAnnuelPris; }

    public Integer getCongesExceptionnelPris() { return congesExceptionnelPris; }
    public void setCongesExceptionnelPris(Integer congesExceptionnelPris) { this.congesExceptionnelPris = congesExceptionnelPris; }

    public Integer getSoldeAnnuel() { return soldeAnnuel; }
    public void setSoldeAnnuel(Integer soldeAnnuel) { this.soldeAnnuel = soldeAnnuel; }

    public Integer getSoldeExceptionnel() { return soldeExceptionnel; }
    public void setSoldeExceptionnel(Integer soldeExceptionnel) { this.soldeExceptionnel = soldeExceptionnel; }

    public Integer getSoldeTotal() { return soldeTotal; }
    public void setSoldeTotal(Integer soldeTotal) { this.soldeTotal = soldeTotal; }

    // Méthode utilitaire pour vérifier si le solde est négatif
    public boolean isSoldeNegatif() {
        return soldeTotal < 0;
    }
    
    public boolean isSoldeAnnuelNegatif() {
        return soldeAnnuel < 0;
    }
    
    public boolean isSoldeExceptionnelNegatif() {
        return soldeExceptionnel < 0;
    }
}