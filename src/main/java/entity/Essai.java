package entity;

import jakarta.persistence.*;

@Entity
public class Essai {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "id_candidat", nullable = false)
    private Integer idCandidat;

    @Column(name = "periode", nullable = false)
    private Integer periode;

    // Getters & Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getIdCandidat() { return idCandidat; }
    public void setIdCandidat(Integer idCandidat) { this.idCandidat = idCandidat; }

    public Integer getPeriode() { return periode; }
    public void setPeriode(Integer periode) { this.periode = periode; }
}
