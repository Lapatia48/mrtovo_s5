package entity;

import jakarta.persistence.*;
import org.hibernate.annotations.Immutable;

@Entity
@Immutable
@Table(name = "vue_employes_pointage")
public class EmployePointage {
    
    @Id
    @Column(name = "id")
    private Integer id;
    
    @Column(name = "nom")
    private String nom;
    
    @Column(name = "prenom")
    private String prenom;
    
    @Column(name = "departement")
    private String departement;
    
    @Column(name = "poste")
    private String poste;
    
    @Column(name = "date_embauche")
    private java.sql.Date dateEmbauche;
    
    @Column(name = "quota_annuel")
    private Integer quotaAnnuel;
    
    @Column(name = "quota_exceptionnel")
    private Integer quotaExceptionnel;
    
    @Column(name = "solde_annuel_actuel")
    private Integer soldeAnnuelActuel;
    
    @Column(name = "solde_exceptionnel_actuel")
    private Integer soldeExceptionnelActuel;

    // Constructeurs
    public EmployePointage() {}

    // Getters et Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }

    public String getDepartement() { return departement; }
    public void setDepartement(String departement) { this.departement = departement; }

    public String getPoste() { return poste; }
    public void setPoste(String poste) { this.poste = poste; }

    public java.sql.Date getDateEmbauche() { return dateEmbauche; }
    public void setDateEmbauche(java.sql.Date dateEmbauche) { this.dateEmbauche = dateEmbauche; }

    public Integer getQuotaAnnuel() { return quotaAnnuel; }
    public void setQuotaAnnuel(Integer quotaAnnuel) { this.quotaAnnuel = quotaAnnuel; }

    public Integer getQuotaExceptionnel() { return quotaExceptionnel; }
    public void setQuotaExceptionnel(Integer quotaExceptionnel) { this.quotaExceptionnel = quotaExceptionnel; }

    public Integer getSoldeAnnuelActuel() { return soldeAnnuelActuel; }
    public void setSoldeAnnuelActuel(Integer soldeAnnuelActuel) { this.soldeAnnuelActuel = soldeAnnuelActuel; }

    public Integer getSoldeExceptionnelActuel() { return soldeExceptionnelActuel; }
    public void setSoldeExceptionnelActuel(Integer soldeExceptionnelActuel) { this.soldeExceptionnelActuel = soldeExceptionnelActuel; }

    // Méthode utilitaire pour le nom complet
    public String getNomComplet() {
        return prenom + " " + nom;
    }
}