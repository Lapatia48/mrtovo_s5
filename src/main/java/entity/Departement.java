package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "departement")
public class Departement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "libelle_departement", length = 100)
    private String libelleDepartement;

    // Getters et Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLibelleDepartement() {
        return libelleDepartement;
    }

    public void setLibelleDepartement(String libelleDepartement) {
        this.libelleDepartement = libelleDepartement;
    }
}
