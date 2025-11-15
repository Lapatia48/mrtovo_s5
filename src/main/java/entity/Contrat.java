package entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "contrat")
public class Contrat {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "id_employe")
    private Integer idEmploye;

    @Column(name = "numero_contrat", unique = true, nullable = false)
    private String numeroContrat;

    @Column(name = "type_contrat", nullable = false)
    private String typeContrat;

    @Column(name = "statut_contrat")
    private String statutContrat = "actif";

    @Column(name = "date_debut", nullable = false)
    private LocalDate dateDebut;

    @Column(name = "date_fin")
    private LocalDate dateFin;

    @Column(name = "poste", nullable = false)
    private String poste;

    @Column(name = "classification")
    private String classification;

    @Column(name = "salaire_base", nullable = false)
    private BigDecimal salaireBase;

    @Column(name = "duree_hebdomadaire")
    private Integer dureeHebdomadaire = 35;

    @Column(name = "temps_travail")
    private String tempsTravail = "Plein";

    @Column(name = "periode_essai_jours")
    private Integer periodeEssaiJours = 0;

    @Column(name = "date_fin_essai")
    private LocalDate dateFinEssai;

    @Column(name = "date_creation")
    private LocalDateTime dateCreation = LocalDateTime.now();

    @Column(name = "date_modification")
    private LocalDateTime dateModification = LocalDateTime.now();

    // Constructeurs
    public Contrat() {}

    public Contrat(Integer idEmploye, String numeroContrat, String typeContrat, LocalDate dateDebut, 
                   String poste, BigDecimal salaireBase) {
        this.idEmploye = idEmploye;
        this.numeroContrat = numeroContrat;
        this.typeContrat = typeContrat;
        this.dateDebut = dateDebut;
        this.poste = poste;
        this.salaireBase = salaireBase;
    }

    // Getters et Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getIdEmploye() { return idEmploye; }
    public void setIdEmploye(Integer idEmploye) { this.idEmploye = idEmploye; }

    public String getNumeroContrat() { return numeroContrat; }
    public void setNumeroContrat(String numeroContrat) { this.numeroContrat = numeroContrat; }

    public String getTypeContrat() { return typeContrat; }
    public void setTypeContrat(String typeContrat) { this.typeContrat = typeContrat; }

    public String getStatutContrat() { return statutContrat; }
    public void setStatutContrat(String statutContrat) { this.statutContrat = statutContrat; }

    public LocalDate getDateDebut() { return dateDebut; }
    public void setDateDebut(LocalDate dateDebut) { this.dateDebut = dateDebut; }

    public LocalDate getDateFin() { return dateFin; }
    public void setDateFin(LocalDate dateFin) { this.dateFin = dateFin; }

    public String getPoste() { return poste; }
    public void setPoste(String poste) { this.poste = poste; }

    public String getClassification() { return classification; }
    public void setClassification(String classification) { this.classification = classification; }

    public BigDecimal getSalaireBase() { return salaireBase; }
    public void setSalaireBase(BigDecimal salaireBase) { this.salaireBase = salaireBase; }

    public Integer getDureeHebdomadaire() { return dureeHebdomadaire; }
    public void setDureeHebdomadaire(Integer dureeHebdomadaire) { this.dureeHebdomadaire = dureeHebdomadaire; }

    public String getTempsTravail() { return tempsTravail; }
    public void setTempsTravail(String tempsTravail) { this.tempsTravail = tempsTravail; }

    public Integer getPeriodeEssaiJours() { return periodeEssaiJours; }
    public void setPeriodeEssaiJours(Integer periodeEssaiJours) { this.periodeEssaiJours = periodeEssaiJours; }

    public LocalDate getDateFinEssai() { return dateFinEssai; }
    public void setDateFinEssai(LocalDate dateFinEssai) { this.dateFinEssai = dateFinEssai; }

    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime dateCreation) { this.dateCreation = dateCreation; }

    public LocalDateTime getDateModification() { return dateModification; }
    public void setDateModification(LocalDateTime dateModification) { this.dateModification = dateModification; }
}