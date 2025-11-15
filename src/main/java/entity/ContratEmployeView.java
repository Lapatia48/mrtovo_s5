package entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "contrat_employe_view")
public class ContratEmployeView {

    @Id
    private Integer id;

    @Column(name = "id_employe")
    private Integer idEmploye;

    @Column(name = "numero_contrat")
    private String numeroContrat;

    @Column(name = "type_contrat")
    private String typeContrat;

    @Column(name = "statut_contrat")
    private String statutContrat;

    @Column(name = "date_debut")
    private LocalDate dateDebut;

    @Column(name = "date_fin")
    private LocalDate dateFin;

    @Column(name = "poste_contrat")
    private String posteContrat;

    @Column(name = "classification")
    private String classification;

    @Column(name = "salaire_base")
    private BigDecimal salaireBase;

    @Column(name = "duree_hebdomadaire")
    private Integer dureeHebdomadaire;

    @Column(name = "temps_travail")
    private String tempsTravail;

    @Column(name = "periode_essai_jours")
    private Integer periodeEssaiJours;

    @Column(name = "date_fin_essai")
    private LocalDate dateFinEssai;

    @Column(name = "date_creation")
    private LocalDateTime dateCreation;

    @Column(name = "date_modification")
    private LocalDateTime dateModification;

    @Column(name = "nom")
    private String nom;

    @Column(name = "prenom")
    private String prenom;

    @Column(name = "mail")
    private String mail;

    @Column(name = "adresse")
    private String adresse;

    @Column(name = "date_naissance")
    private LocalDate dateNaissance;

    @Column(name = "age")
    private Integer age;

    @Column(name = "departement")
    private String departement;

    @Column(name = "poste_employe")
    private String posteEmploye;

    @Column(name = "annee_experience")
    private Integer anneeExperience;

    @Column(name = "diplome")
    private String diplome;

    @Column(name = "date_embauche")
    private LocalDate dateEmbauche;

    @Column(name = "salaire_employe")
    private Integer salaireEmploye;

    @Column(name = "statut_employe")
    private String statutEmploye;

    // Constructeurs
    public ContratEmployeView() {}

    // Getters et Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getIdEmploye() { return idEmploye; }
    public void setIdEmploye(Integer idEmploye) { this.idEmploye = idEmploye; }

    public String getNumeroContrat() { return numeroContrat; }
    public void setNumeroContrat(String numeroContrat) { this.numeroContrat = numeroContrat; }

    public String getTypeContrat() { return typeContrat; }
    public void setTypeContrat(String typeContrat) { this.typeContrat = typeContrat; }

    public String getStatutContrat() { return statutContrat; }
    public void setStatutContrat(String statutContrat) { this.statutContrat = statutContrat; }

    public LocalDate getDateDebut() { return dateDebut; }
    public void setDateDebut(LocalDate dateDebut) { this.dateDebut = dateDebut; }

    public LocalDate getDateFin() { return dateFin; }
    public void setDateFin(LocalDate dateFin) { this.dateFin = dateFin; }

    public String getPosteContrat() { return posteContrat; }
    public void setPosteContrat(String posteContrat) { this.posteContrat = posteContrat; }

    public String getClassification() { return classification; }
    public void setClassification(String classification) { this.classification = classification; }

    public BigDecimal getSalaireBase() { return salaireBase; }
    public void setSalaireBase(BigDecimal salaireBase) { this.salaireBase = salaireBase; }

    public Integer getDureeHebdomadaire() { return dureeHebdomadaire; }
    public void setDureeHebdomadaire(Integer dureeHebdomadaire) { this.dureeHebdomadaire = dureeHebdomadaire; }

    public String getTempsTravail() { return tempsTravail; }
    public void setTempsTravail(String tempsTravail) { this.tempsTravail = tempsTravail; }

    public Integer getPeriodeEssaiJours() { return periodeEssaiJours; }
    public void setPeriodeEssaiJours(Integer periodeEssaiJours) { this.periodeEssaiJours = periodeEssaiJours; }

    public LocalDate getDateFinEssai() { return dateFinEssai; }
    public void setDateFinEssai(LocalDate dateFinEssai) { this.dateFinEssai = dateFinEssai; }

    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime dateCreation) { this.dateCreation = dateCreation; }

    public LocalDateTime getDateModification() { return dateModification; }
    public void setDateModification(LocalDateTime dateModification) { this.dateModification = dateModification; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }

    public String getMail() { return mail; }
    public void setMail(String mail) { this.mail = mail; }

    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }

    public LocalDate getDateNaissance() { return dateNaissance; }
    public void setDateNaissance(LocalDate dateNaissance) { this.dateNaissance = dateNaissance; }

    public Integer getAge() { return age; }
    public void setAge(Integer age) { this.age = age; }

    public String getDepartement() { return departement; }
    public void setDepartement(String departement) { this.departement = departement; }

    public String getPosteEmploye() { return posteEmploye; }
    public void setPosteEmploye(String posteEmploye) { this.posteEmploye = posteEmploye; }

    public Integer getAnneeExperience() { return anneeExperience; }
    public void setAnneeExperience(Integer anneeExperience) { this.anneeExperience = anneeExperience; }

    public String getDiplome() { return diplome; }
    public void setDiplome(String diplome) { this.diplome = diplome; }

    public LocalDate getDateEmbauche() { return dateEmbauche; }
    public void setDateEmbauche(LocalDate dateEmbauche) { this.dateEmbauche = dateEmbauche; }

    public Integer getSalaireEmploye() { return salaireEmploye; }
    public void setSalaireEmploye(Integer salaireEmploye) { this.salaireEmploye = salaireEmploye; }

    public String getStatutEmploye() { return statutEmploye; }
    public void setStatutEmploye(String statutEmploye) { this.statutEmploye = statutEmploye; }
}