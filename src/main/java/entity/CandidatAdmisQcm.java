package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "candidat_admis_qcm")
public class CandidatAdmisQcm {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "id_candidat", nullable = false)
    private Integer idCandidat;

    // Champs temporaires pour l'affichage
    @Transient
    private String  nom;
    @Transient
    private String prenom;
    @Transient
    private String mail;

    // Getters et Setters
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
}
