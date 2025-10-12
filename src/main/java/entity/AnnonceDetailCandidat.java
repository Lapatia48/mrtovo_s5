package entity;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "annonce_detail_candidat")
public class AnnonceDetailCandidat {
    
    @Id
    @Column(name = "candidat_id")
    private Integer candidatId;
    
    @Column(name = "id_annonce_postule")
    private Integer idAnnoncePostule;
    
    @Column(name = "annonce_id")
    private Integer annonceId;
    
    @Column(name = "titre", length = 150)
    private String titre;
    
    @Column(name = "description", columnDefinition = "TEXT")
    private String description;
    
    @Column(name = "date_publication")
    @Temporal(TemporalType.DATE)
    private Date datePublication;
    
    @Column(name = "age_min")
    private Integer ageMin;
    
    @Column(name = "age_max")
    private Integer ageMax;
    
    @Column(name = "nb_personne_utile")
    private Integer nbPersonneUtile;
    
    @Column(name = "salaire")
    private Integer salaire;
    
    @Column(name = "diplome_requis", length = 100)
    private String diplomeRequis;
    
    @Column(name = "departement_annonce", length = 100)
    private String departementAnnonce;

    // --- Getters & Setters ---
    public Integer getCandidatId() {
        return candidatId;
    }

    public void setCandidatId(Integer candidatId) {
        this.candidatId = candidatId;
    }

    public Integer getIdAnnoncePostule() {
        return idAnnoncePostule;
    }

    public void setIdAnnoncePostule(Integer idAnnoncePostule) {
        this.idAnnoncePostule = idAnnoncePostule;
    }

    public Integer getAnnonceId() {
        return annonceId;
    }

    public void setAnnonceId(Integer annonceId) {
        this.annonceId = annonceId;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDatePublication() {
        return datePublication;
    }

    public void setDatePublication(Date datePublication) {
        this.datePublication = datePublication;
    }

    public Integer getAgeMin() {
        return ageMin;
    }

    public void setAgeMin(Integer ageMin) {
        this.ageMin = ageMin;
    }

    public Integer getAgeMax() {
        return ageMax;
    }

    public void setAgeMax(Integer ageMax) {
        this.ageMax = ageMax;
    }

    public Integer getNbPersonneUtile() {
        return nbPersonneUtile;
    }

    public void setNbPersonneUtile(Integer nbPersonneUtile) {
        this.nbPersonneUtile = nbPersonneUtile;
    }

    public Integer getSalaire() {
        return salaire;
    }

    public void setSalaire(Integer salaire) {
        this.salaire = salaire;
    }

    public String getDiplomeRequis() {
        return diplomeRequis;
    }

    public void setDiplomeRequis(String diplomeRequis) {
        this.diplomeRequis = diplomeRequis;
    }

    public String getDepartementAnnonce() {
        return departementAnnonce;
    }

    public void setDepartementAnnonce(String departementAnnonce) {
        this.departementAnnonce = departementAnnonce;
    }
}