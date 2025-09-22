package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "note_qcm")
public class NoteQcm {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "id_candidat", nullable = false)
    private Integer idCandidat;

    @Column(nullable = false)
    private Integer note;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getIdCandidat() { return idCandidat; }
    public void setIdCandidat(Integer idCandidat) { this.idCandidat = idCandidat; }

    public Integer getNote() { return note; }
    public void setNote(Integer note) { this.note = note; }
}
