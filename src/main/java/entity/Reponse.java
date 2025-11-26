package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "reponse")
public class Reponse {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "id_question", nullable = false)
    private Integer idQuestion;

    @Column(name = "reponse", length = 255, nullable = false)
    private String reponse;

    public Reponse() {}

    public Reponse(Integer idQuestion, String reponse) {
        this.idQuestion = idQuestion;
        this.reponse = reponse;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getIdQuestion() { return idQuestion; }
    public void setIdQuestion(Integer idQuestion) { this.idQuestion = idQuestion; }

    public String getReponse() { return reponse; }
    public void setReponse(String reponse) { this.reponse = reponse; }
}
