package entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "entretien")
public class Entretien {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "id_candidat", nullable = false)
    private Integer idCandidat;

    @Column(name = "date_entretien")
    private LocalDate dateEntretien;

    @Column(name = "commentaire", columnDefinition = "TEXT")
    private String commentaire;

    @Column(name = "statut", length = 50)
    private String statut;

    @Column(name = "salaire_nifanarahana")
    private Integer salaireNifanarahana;

    // Getters et Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getIdCandidat() { return idCandidat; }
    public void setIdCandidat(Integer idCandidat) { this.idCandidat = idCandidat; }

    public LocalDate getDateEntretien() { return dateEntretien; }
    public void setDateEntretien(LocalDate dateEntretien) { this.dateEntretien = dateEntretien; }

    public String getCommentaire() { return commentaire; }
    public void setCommentaire(String commentaire) { this.commentaire = commentaire; }

    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }

    public Integer getSalaireNifanarahana() { return salaireNifanarahana; }
    public void setSalaireNifanarahana(Integer salaireNifanarahana) { this.salaireNifanarahana = salaireNifanarahana; }
}
