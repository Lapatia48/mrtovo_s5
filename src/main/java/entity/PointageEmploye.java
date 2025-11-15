package entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "pointage_employe")
public class PointageEmploye {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(name = "id_employe")
    private Integer idEmploye;
    
    @Column(name = "date_evenement")
    private LocalDate dateEvenement;
    
    @Column(name = "type_evenement")
    private String typeEvenement;
    
    @Column(name = "sous_type")
    private String sousType;
    
    @Column(name = "duree_jours")
    private Double dureeJours;
    
    @Column(name = "heures_retard")
    private Integer heuresRetard;
    
    @Column(name = "equivalent_jours")
    private Double equivalentJours;
    
    @Column(name = "impact_annuel")
    private Double impactAnnuel;
    
    @Column(name = "impact_exceptionnel")
    private Double impactExceptionnel;
    
    @Column(name = "motif")
    private String motif;
    
    @Column(name = "statut")
    private String statut;
    
    @Column(name = "date_saisie")
    private LocalDateTime dateSaisie;

    // Constructeur
    public PointageEmploye() {
        this.statut = "valide";
        this.dateSaisie = LocalDateTime.now();
    }

    // Getters et Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getIdEmploye() { return idEmploye; }
    public void setIdEmploye(Integer idEmploye) { this.idEmploye = idEmploye; }

    public LocalDate getDateEvenement() { return dateEvenement; }
    public void setDateEvenement(LocalDate dateEvenement) { this.dateEvenement = dateEvenement; }

    public String getTypeEvenement() { return typeEvenement; }
    public void setTypeEvenement(String typeEvenement) { this.typeEvenement = typeEvenement; }

    public String getSousType() { return sousType; }
    public void setSousType(String sousType) { this.sousType = sousType; }

    public Double getDureeJours() { return dureeJours; }
    public void setDureeJours(Double dureeJours) { this.dureeJours = dureeJours; }

    public Integer getHeuresRetard() { return heuresRetard; }
    public void setHeuresRetard(Integer heuresRetard) { this.heuresRetard = heuresRetard; }

    public Double getEquivalentJours() { return equivalentJours; }
    public void setEquivalentJours(Double equivalentJours) { this.equivalentJours = equivalentJours; }

    public Double getImpactAnnuel() { return impactAnnuel; }
    public void setImpactAnnuel(Double impactAnnuel) { this.impactAnnuel = impactAnnuel; }

    public Double getImpactExceptionnel() { return impactExceptionnel; }
    public void setImpactExceptionnel(Double impactExceptionnel) { this.impactExceptionnel = impactExceptionnel; }

    public String getMotif() { return motif; }
    public void setMotif(String motif) { this.motif = motif; }

    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }

    public LocalDateTime getDateSaisie() { return dateSaisie; }
    public void setDateSaisie(LocalDateTime dateSaisie) { this.dateSaisie = dateSaisie; }
}