package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "questions_reponses_view")
public class QuestionsReponsesView {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(name = "question_id")
    private Integer questionId;
    
    @Column(name = "question")
    private String question;
    
    @Column(name = "id_departement")
    private Integer idDepartement;
    
    @Column(name = "reponse_id")
    private Integer reponseId;
    
    @Column(name = "reponse")
    private String reponse;
    
    @Column(name = "est_vraie")
    private Boolean estVraie;

    // --- Getters & Setters ---
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getQuestionId() {
        return questionId;
    }

    public void setQuestionId(Integer questionId) {
        this.questionId = questionId;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public Integer getIdDepartement() {
        return idDepartement;
    }

    public void setIdDepartement(Integer idDepartement) {
        this.idDepartement = idDepartement;
    }

    public Integer getReponseId() {
        return reponseId;
    }

    public void setReponseId(Integer reponseId) {
        this.reponseId = reponseId;
    }

    public String getReponse() {
        return reponse;
    }

    public void setReponse(String reponse) {
        this.reponse = reponse;
    }

    public Boolean getEstVraie() {
        return estVraie;
    }

    public void setEstVraie(Boolean estVraie) {
        this.estVraie = estVraie;
    }
}