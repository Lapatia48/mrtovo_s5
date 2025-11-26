package entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "conge_etat_details")
public class CongeEtatDetails {
    
    @Id
    @Column(name = "id")
    private Integer id;

    @Column(name = "id_employe")
    private Integer idEmploye;

    @Column(name = "statut", length = 50)
    private String statut;

    @Column(name = "date_demande")
    private LocalDate dateDemande;

    @Column(name = "date_validation")
    private LocalDate dateValidation;

    @Column(name = "duree")
    private Integer duree;

    @Column(name = "date_debut")
    private LocalDate dateDebut;

    @Column(name = "date_fin")
    private LocalDate dateFin;

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

    @Column(name = "quota")
    private Integer quota;

    @Column(name = "annee")
    private Integer annee;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getIdEmploye() { return idEmploye; }
    public void setIdEmploye(Integer idEmploye) { this.idEmploye = idEmploye; }
    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }
    public LocalDate getDateDemande() { return dateDemande; }
    public void setDateDemande(LocalDate dateDemande) { this.dateDemande = dateDemande; }
    public LocalDate getDateValidation() { return dateValidation; }
    public void setDateValidation(LocalDate dateValidation) { this.dateValidation = dateValidation; }
    public Integer getDuree() { return duree; }
    public void setDuree(Integer duree) { this.duree = duree; }
    public LocalDate getDateDebut() { return dateDebut; }
    public void setDateDebut(LocalDate dateDebut) { this.dateDebut = dateDebut; }
    public LocalDate getDateFin() { return dateFin; }
    public void setDateFin(LocalDate dateFin) { this.dateFin = dateFin; }
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
    public Integer getQuota() { return quota; }
    public void setQuota(Integer quota) { this.quota = quota; }
    public Integer getAnnee() { return annee; }
    public void setAnnee(Integer annee) { this.annee = annee; }
}