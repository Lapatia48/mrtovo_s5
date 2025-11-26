package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "vrai_reponse")
public class VraiReponse {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "id_question", nullable = false)
    private Integer idQuestion;

    @Column(name = "id_reponse", nullable = false)
    private Integer idReponse;

    public VraiReponse() {}

    public VraiReponse(Integer idQuestion, Integer idReponse) {
        this.idQuestion = idQuestion;
        this.idReponse = idReponse;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getIdQuestion() { return idQuestion; }
    public void setIdQuestion(Integer idQuestion) { this.idQuestion = idQuestion; }

    public Integer getIdReponse() { return idReponse; }
    public void setIdReponse(Integer idReponse) { this.idReponse = idReponse; }
}
