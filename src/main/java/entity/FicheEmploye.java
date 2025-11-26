package entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "fiche_employe")
public class FicheEmploye {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "id_employe", unique = true)
    private Integer idEmploye;

    @Column(name = "photo_url")
    private String photoUrl;

    @Column(name = "telephone")
    private String telephone;

    @Column(name = "contact_urgence_nom")
    private String contactUrgenceNom;

    @Column(name = "contact_urgence_telephone")
    private String contactUrgenceTelephone;

    @Column(name = "numero_securite_sociale")
    private String numeroSecuriteSociale;

    @Column(name = "date_creation")
    private LocalDateTime dateCreation = LocalDateTime.now();

    @Column(name = "date_modification")
    private LocalDateTime dateModification = LocalDateTime.now();

    

    // Constructeurs
    public FicheEmploye() {}

    public FicheEmploye(Integer idEmploye) {
        this.idEmploye = idEmploye;
        this.photoUrl = "/uploads/employes/default_avatar.png"; // Photo par défaut
    }

    // Getters et Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getIdEmploye() { return idEmploye; }
    public void setIdEmploye(Integer idEmploye) { this.idEmploye = idEmploye; }

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

    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime dateCreation) { this.dateCreation = dateCreation; }

    public LocalDateTime getDateModification() { return dateModification; }
    public void setDateModification(LocalDateTime dateModification) { this.dateModification = dateModification; }
}