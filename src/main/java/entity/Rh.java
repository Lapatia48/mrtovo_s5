package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "rh")
public class Rh {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "nom", length = 100)
    private String nom;

    @Column(name = "mdp", length = 100)
    private String mdp;

    // --- Getters & Setters ---
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }
    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getMdp() {
        return mdp;
    }
    public void setMdp(String mdp) {
        this.mdp = mdp;
    }
}
