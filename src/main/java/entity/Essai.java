package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "essai")
public class Essai {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "id_candidat", nullable = false)
    private Integer idCandidat;

    @Column(name = "salaire")
    private Integer salaire;

    @Column(name = "periode")
    private Integer periode;

    // ===== Constructeurs =====
    public Essai() {}

    public Essai(Integer idCandidat, Integer salaire, Integer periode) {
        this.idCandidat = idCandidat;
        this.salaire = salaire;
        this.periode = periode;
    }

    // ===== Getters & Setters =====
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getIdCandidat() {
        return idCandidat;
    }

    public void setIdCandidat(Integer idCandidat) {
        this.idCandidat = idCandidat;
    }

    public Integer getSalaire() {
        return salaire;
    }

    public void setSalaire(Integer salaire) {
        this.salaire = salaire;
    }

    public Integer getPeriode() {
        return periode;
    }

    public void setPeriode(Integer periode) {
        this.periode = periode;
    }
}