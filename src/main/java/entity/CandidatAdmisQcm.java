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

    // ===== Constructeurs =====
    public CandidatAdmisQcm() {}

    public CandidatAdmisQcm(Integer idCandidat) {
        this.idCandidat = idCandidat;
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
}