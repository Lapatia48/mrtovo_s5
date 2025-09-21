package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "candidat_refuse")
public class CandidatRefuse {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "id_candidat", nullable = false)
    private Integer idCandidat;

    @Column(name = "libelle_etape", length = 100)
    private String libelleEtape;

    // ===== Constructeurs =====
    public CandidatRefuse() {}

    public CandidatRefuse(Integer idCandidat, String libelleEtape) {
        this.idCandidat = idCandidat;
        this.libelleEtape = libelleEtape;
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

    public String getLibelleEtape() {
        return libelleEtape;
    }

    public void setLibelleEtape(String libelleEtape) {
        this.libelleEtape = libelleEtape;
    }
}
