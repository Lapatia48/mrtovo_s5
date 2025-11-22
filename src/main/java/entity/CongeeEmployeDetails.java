package entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "congee_employe_details")
public class CongeeEmployeDetails {
    
    @Id
    @Column(name = "id")
    private Integer id;

    @Column(name = "id_employe")
    private Integer idEmploye;

    @Column(name = "quota")
    private Integer quota;

    @Column(name = "annee")
    private Integer annee;  

    @Column(name = "nom", length = 100)
    private String nom;

    @Column(name = "prenom", length = 100)
    private String prenom;

    @Column(name = "mail", length = 150)
    private String mail;

    @Column(name = "departement", length = 100)
    private String departement;

    @Column(name = "poste", length = 100)
    private String poste;

    @Column(name = "date_embauche")
    private LocalDate dateEmbauche;

    @Column(name = "statut_employe", length = 50)
    private String statutEmploye;

    @Column(name = "conges_pris")
    private Long congesPris;

    @Column(name = "jours_pris")
    private Integer joursPris;

    @Column(name = "solde_restant")
    private Integer soldeRestant;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getIdEmploye() { return idEmploye; }
    public void setIdEmploye(Integer idEmploye) { this.idEmploye = idEmploye; }
    public Integer getQuota() { return quota; }
    public void setQuota(Integer quota) { this.quota = quota; }
    public Integer getAnnee() { return annee; }
    public void setAnnee(Integer annee) { this.annee = annee; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }
    public String getMail() { return mail; }
    public void setMail(String mail) { this.mail = mail; }
    public String getDepartement() { return departement; }
    public void setDepartement(String departement) { this.departement = departement; }
    public String getPoste() { return poste; }
    public void setPoste(String poste) { this.poste = poste; }
    public LocalDate getDateEmbauche() { return dateEmbauche; }
    public void setDateEmbauche(LocalDate dateEmbauche) { this.dateEmbauche = dateEmbauche; }
    public String getStatutEmploye() { return statutEmploye; }
    public void setStatutEmploye(String statutEmploye) { this.statutEmploye = statutEmploye; }
    public Long getCongesPris() { return congesPris; }
    public void setCongesPris(Long congesPris) { this.congesPris = congesPris; }
    public Integer getJoursPris() { return joursPris; }
    public void setJoursPris(Integer joursPris) { this.joursPris = joursPris; }
    public Integer getSoldeRestant() { return soldeRestant; }
    public void setSoldeRestant(Integer soldeRestant) { this.soldeRestant = soldeRestant; }
}