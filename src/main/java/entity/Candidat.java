package entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "candidat")
public class Candidat {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "nom", length = 100)
    private String nom;

    @Column(name = "prenom", length = 100)
    private String prenom;

    @Column(name = "mail", length = 150, unique = true)
    private String mail;

    @Column(name = "adresse", length = 200)
    private String adresse;

    @Column(name = "date_naissance")
    private LocalDate dateNaissance;

    @Column(name = "renseignement", columnDefinition = "TEXT")
    private String renseignement;

    @Column(name = "id_diplome")
    private Integer idDiplome;

    @Column(name = "annee_experience")
    private Integer anneeExperience;

    @Column(name = "id_departement")
    private Integer idDepartement;

    @Column(name = "date_postule")
    private LocalDate datePostule;

    // ===== Constructeurs =====
    public Candidat() {}

    // ===== Getters & Setters =====
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public LocalDate getDateNaissance() {
        return dateNaissance;
    }

    public void setDateNaissance(LocalDate dateNaissance) {
        this.dateNaissance = dateNaissance;
    }

    public String getRenseignement() {
        return renseignement;
    }

    public void setRenseignement(String renseignement) {
        this.renseignement = renseignement;
    }

    public Integer getIdDiplome() {
        return idDiplome;
    }

    public void setIdDiplome(Integer idDiplome) {
        this.idDiplome = idDiplome;
    }

    public Integer getAnneeExperience() {
        return anneeExperience;
    }

    public void setAnneeExperience(Integer anneeExperience) {
        this.anneeExperience = anneeExperience;
    }

    public Integer getIdDepartement() {
        return idDepartement;
    }

    public void setIdDepartement(Integer idDepartement) {
        this.idDepartement = idDepartement;
    }

    public LocalDate getDatePostule() {
        return datePostule;
    }

    public void setDatePostule(LocalDate datePostule) {
        this.datePostule = datePostule;
    }
}
