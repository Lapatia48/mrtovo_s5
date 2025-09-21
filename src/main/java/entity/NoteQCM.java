package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "note_qcm")
public class NoteQCM {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "id_candidat", nullable = false)
    private Integer idCandidat;

    @Column(name = "note", nullable = false)
    private Integer note;

    public NoteQCM() {}

    public NoteQCM(Integer idCandidat, Integer note) {
        this.idCandidat = idCandidat;
        this.note = note;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getIdCandidat() { return idCandidat; }
    public void setIdCandidat(Integer idCandidat) { this.idCandidat = idCandidat; }

    public Integer getNote() { return note; }
    public void setNote(Integer note) { this.note = note; }
}
