package entity;
import jakarta.persistence.*;

@Entity
@Table(name = "candidat_details_view")
public class CandidatDetailsView {

    @Id
    private Integer id;

    private String nom;
    private String prenom;
    private String mail;
    private String adresse;

    @Column(name = "date_naissance")
    private java.time.LocalDate dateNaissance;

    private Integer age;

    private String renseignement;

    @Column(name = "annee_experience")
    private Integer anneeExperience;

    @Column(name = "date_postule")
    private java.time.LocalDate datePostule;

    @Column(name = "nom_diplome")
    private String diplome;

    @Column(name = "libelle_departement")
    private String departement;

    // Getters & Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }

    public String getMail() { return mail; }
    public void setMail(String mail) { this.mail = mail; }

    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }

    public java.time.LocalDate getDateNaissance() { return dateNaissance; }
    public void setDateNaissance(java.time.LocalDate dateNaissance) { this.dateNaissance = dateNaissance; }

    public Integer getAge() { return age; }
    public void setAge(Integer age) { this.age = age; }

    public String getRenseignement() { return renseignement; }
    public void setRenseignement(String renseignement) { this.renseignement = renseignement; }

    public Integer getAnneeExperience() { return anneeExperience; }
    public void setAnneeExperience(Integer anneeExperience) { this.anneeExperience = anneeExperience; }

    public java.time.LocalDate getDatePostule() { return datePostule; }
    public void setDatePostule(java.time.LocalDate datePostule) { this.datePostule = datePostule; }

    public String getDiplome() { return diplome; }
    public void setDiplome(String diplome) { this.diplome = diplome; }

    public String getDepartement() { return departement; }
    public void setDepartement(String departement) { this.departement = departement; }
}
