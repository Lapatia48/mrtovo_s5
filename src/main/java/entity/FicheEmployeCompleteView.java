package entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "fiche_employe_complete_view")
public class FicheEmployeCompleteView {

    @Id
    private Integer id;

    @Column(name = "id_candidat")
    private Integer idCandidat;

    private String nom;
    private String prenom;
    private String mail;
    private String adresse;
    
    @Column(name = "date_naissance")
    private LocalDate dateNaissance;
    
    private Integer age;
    private String renseignement;
    private String diplome;
    
    @Column(name = "annee_experience")
    private Integer anneeExperience;
    
    private String departement;
    private String poste;
    
    @Column(name = "date_embauche")
    private LocalDate dateEmbauche;
    
    @Column(name = "anciennete_annees")
    private Integer ancienneteAnnees;
    
    private Integer salaire;
    private String statut;
    
    // Nouveaux champs fiche employé
    @Column(name = "photo_url")
    private String photoUrl;
    
    private String telephone;
    
    @Column(name = "contact_urgence_nom")
    private String contactUrgenceNom;
    
    @Column(name = "contact_urgence_telephone")
    private String contactUrgenceTelephone;
    
    @Column(name = "numero_securite_sociale")
    private String numeroSecuriteSociale;
    
    // Champs contrat
    @Column(name = "type_contrat")
    private String typeContrat;
    
    @Column(name = "date_debut")
    private LocalDate dateDebut;
    
    @Column(name = "date_fin")
    private LocalDate dateFin;
    
    private String classification;
    
    @Column(name = "salaire_base")
    private BigDecimal salaireBase;
    
    @Column(name = "periode_essai_jours")
    private Integer periodeEssaiJours;
    
    @Column(name = "date_fin_essai")
    private LocalDate dateFinEssai;

  



    @Override
    public String toString() {
        return "FicheEmployeCompleteView{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", prenom='" + prenom + '\'' +
                // seulement les champs de base, pas les relations
                '}';
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        FicheEmployeCompleteView that = (FicheEmployeCompleteView) o;
        return Objects.equals(id, that.id);
    }
    // Getters et Setters pour tous les champs
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
    // public String getMotDePasse() { return motDePasse; }
    // public void setMotDePasse(String motDePasse) { this.motDePasse = motDePasse; }
    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }
    public LocalDate getDateNaissance() { return dateNaissance; }
    public void setDateNaissance(LocalDate dateNaissance) { this.dateNaissance = dateNaissance; }
    public Integer getAge() { return age; }
    public void setAge(Integer age) { this.age = age; }
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
    public Integer getAncienneteAnnees() { return ancienneteAnnees; }
    public void setAncienneteAnnees(Integer ancienneteAnnees) { this.ancienneteAnnees = ancienneteAnnees; }
    public Integer getSalaire() { return salaire; }
    public void setSalaire(Integer salaire) { this.salaire = salaire; }
    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }
    public String getPhotoUrl() { return photoUrl; }
    public void setPhotoUrl(String photoUrl) { this.photoUrl = photoUrl; }
    public String getTelephone() { return telephone; }
    public void setTelephone(String telephone) { this.telephone = telephone; }
    public String getContactUrgenceNom() { return contactUrgenceNom; }
    public void setContactUrgenceNom(String contactUrgenceNom) { this.contactUrgenceNom = contactUrgenceNom; }
    public String getContactUrgenceTelephone() { return contactUrgenceTelephone; }
    public void setContactUrgenceTelephone(String contactUrgenceTelephone) { this.contactUrgenceTelephone = contactUrgenceTelephone; }
    public String getNumeroSecuriteSociale() { return numeroSecuriteSociale; }
    public void setNumeroSecuriteSociale(String numeroSecuriteSociale) { this.numeroSecuriteSociale = numeroSecuriteSociale; }
    public String getTypeContrat() { return typeContrat; }
    public void setTypeContrat(String typeContrat) { this.typeContrat = typeContrat; }
    public LocalDate getDateDebut() { return dateDebut; }
    public void setDateDebut(LocalDate dateDebut) { this.dateDebut = dateDebut; }
    public LocalDate getDateFin() { return dateFin; }
    public void setDateFin(LocalDate dateFin) { this.dateFin = dateFin; }
    public String getClassification() { return classification; }
    public void setClassification(String classification) { this.classification = classification; }
    public BigDecimal getSalaireBase() { return salaireBase; }
    public void setSalaireBase(BigDecimal salaireBase) { this.salaireBase = salaireBase; }
    public Integer getPeriodeEssaiJours() { return periodeEssaiJours; }
    public void setPeriodeEssaiJours(Integer periodeEssaiJours) { this.periodeEssaiJours = periodeEssaiJours; }
    public LocalDate getDateFinEssai() { return dateFinEssai; }
    public void setDateFinEssai(LocalDate dateFinEssai) { this.dateFinEssai = dateFinEssai; }
}