package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "candidat_admis_qcm_details")
public class CandidatAdmisQcmDetails {

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

    @Column(name = "annonce_postulee")
    private String annoncePostulee;

    @Column(name = "salaire_annonce")
    private Integer salaireAnnonce;

    @Column(name = "note_qcm")
    private Integer noteQcm;

    @Column(name = "id_admission_qcm")
    private Integer idAdmissionQcm;

    @Column(name = "id_candidat")
    private Integer idCandidat;

    // ===== Getters & Setters =====
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

    public String getAnnoncePostulee() { return annoncePostulee; }
    public void setAnnoncePostulee(String annoncePostulee) { this.annoncePostulee = annoncePostulee; }

    public Integer getSalaireAnnonce() { return salaireAnnonce; }
    public void setSalaireAnnonce(Integer salaireAnnonce) { this.salaireAnnonce = salaireAnnonce; }

    public Integer getNoteQcm() { return noteQcm; }
    public void setNoteQcm(Integer noteQcm) { this.noteQcm = noteQcm; }

    public Integer getIdAdmissionQcm() { return idAdmissionQcm; }
    public void setIdAdmissionQcm(Integer idAdmissionQcm) { this.idAdmissionQcm = idAdmissionQcm; }

    public Integer getIdCandidat() { return idCandidat; }
    public void setIdCandidat(Integer idCandidat) { this.idCandidat = idCandidat; }
}