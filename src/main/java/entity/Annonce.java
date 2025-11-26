package entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "annonce")
public class Annonce {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "age_min")
    private Integer ageMin;

    @Column(name = "age_max")
    private Integer ageMax;

    @Column(name = "id_departement")
    private Integer idDepartement;

    @Column(name = "titre", length = 150)
    private String titre;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "date_publication")
    private LocalDate datePublication;

    @Column(name = "nb_personne_utile")
    private Integer nbPersonneUtile;

    @Column(name = "salaire")
    private Integer salaire;

    @Column(name = "id_diplome_requis")
    private Integer idDiplomeRequis;

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getIdDepartement() {
        return idDepartement;
    }

    public void setIdDepartement(Integer idDepartement) {
        this.idDepartement = idDepartement;
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

    public LocalDate getDatePublication() {
        return datePublication;
    }

    public void setDatePublication(LocalDate datePublication) {
        this.datePublication = datePublication;
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

    public Integer getIdDiplomeRequis() {
        return idDiplomeRequis;
    }

    public void setIdDiplomeRequis(Integer idDiplomeRequis) {
        this.idDiplomeRequis = idDiplomeRequis;
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
}
