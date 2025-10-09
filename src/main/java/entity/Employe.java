package entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.Period;

@Entity
@Table(name = "employe")
public class Employe {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "id_candidat")
    private Integer idCandidat;

    private String nom;
    private String prenom;
    private String mail;

    @Column(name = "mot_de_passe")
    private String motDePasse;

    private String adresse;

    @Column(name = "date_naissance")
    private LocalDate dateNaissance;

    private String renseignement;
    private String diplome;

    @Column(name = "annee_experience")
    private Integer anneeExperience;

    private String departement;
    private String poste;

    @Column(name = "date_embauche")
    private LocalDate dateEmbauche;

    private Integer salaire;
    private String statut;

    // ===== Constructeurs =====
    public Employe() {}

    public Employe(Integer idCandidat, String nom, String prenom, String mail, String motDePasse, 
                   String adresse, LocalDate dateNaissance, String renseignement, String diplome,
                   Integer anneeExperience, String departement, String poste, Integer salaire) {
        this.idCandidat = idCandidat;
        this.nom = nom;
        this.prenom = prenom;
        this.mail = mail;
        this.motDePasse = motDePasse;
        this.adresse = adresse;
        this.dateNaissance = dateNaissance;
        this.renseignement = renseignement;
        this.diplome = diplome;
        this.anneeExperience = anneeExperience;
        this.departement = departement;
        this.poste = poste;
        this.dateEmbauche = LocalDate.now();
        this.salaire = salaire;
        this.statut = "actif";
    }

    // ===== Getters & Setters =====
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getIdCandidat() { return idCandidat; }
    public void setIdCandidat(Integer idCandidat) { this.idCandidat = idCandidat; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }

    public String getMail() { return mail; }
    public void setMail(String mail) { this.mail = mail; }

    public String getMotDePasse() { return motDePasse; }
    public void setMotDePasse(String motDePasse) { this.motDePasse = motDePasse; }

    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }

    public LocalDate getDateNaissance() { return dateNaissance; }
    public void setDateNaissance(LocalDate dateNaissance) { this.dateNaissance = dateNaissance; }

    public String getRenseignement() { return renseignement; }
    public void setRenseignement(String renseignement) { this.renseignement = renseignement; }

    public String getDiplome() { return diplome; }
    public void setDiplome(String diplome) { this.diplome = diplome; }

    public Integer getAnneeExperience() { return anneeExperience; }
    public void setAnneeExperience(Integer anneeExperience) { this.anneeExperience = anneeExperience; }

    public String getDepartement() { return departement; }
    public void setDepartement(String departement) { this.departement = departement; }

    public String getPoste() { return poste; }
    public void setPoste(String poste) { this.poste = poste; }

    public LocalDate getDateEmbauche() { return dateEmbauche; }
    public void setDateEmbauche(LocalDate dateEmbauche) { this.dateEmbauche = dateEmbauche; }

    public Integer getSalaire() { return salaire; }
    public void setSalaire(Integer salaire) { this.salaire = salaire; }

    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }

    public Integer getAge() {
        if (this.dateNaissance == null) {
            return null;
        }
        return Period.between(this.dateNaissance, LocalDate.now()).getYears();
    }
}