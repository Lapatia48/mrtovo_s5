package entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "paie")
public class Paie {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "id_employe")
    private Integer idEmploye;

    @Column(name = "date_paie")
    private LocalDate datePaie;

    @Column(name = "periode_debut")
    private LocalDate periodeDebut;

    @Column(name = "periode_fin")
    private LocalDate periodeFin;

    @Column(name = "salaire_base", precision = 15, scale = 2)
    private BigDecimal salaireBase;

    @Column(name = "heures_sup_normales", precision = 15, scale = 2)
    private BigDecimal heuresSupNormales;

    @Column(name = "heures_sup_weekend", precision = 15, scale = 2)
    private BigDecimal heuresSupWeekend;

    @Column(name = "prime_anciennete", precision = 15, scale = 2)
    private BigDecimal primeAnciennete;

    @Column(name = "absences", precision = 15, scale = 2)
    private BigDecimal absences;

    @Column(name = "autres_primes", precision = 15, scale = 2)
    private BigDecimal autresPrimes;

    @Column(name = "salaire_brut", precision = 15, scale = 2)
    private BigDecimal salaireBrut;

    @Column(name = "retenue_cnaps", precision = 15, scale = 2)
    private BigDecimal retenueCnaps;

    @Column(name = "retenue_ostie", precision = 15, scale = 2)
    private BigDecimal retenueOstie;

    @Column(name = "retenue_irsa", precision = 15, scale = 2)
    private BigDecimal retenueIrsa;

    @Column(name = "total_retenues", precision = 15, scale = 2)
    private BigDecimal totalRetenues;

    @Column(name = "net_a_payer", precision = 15, scale = 2)
    private BigDecimal netAPayer;

    @Column(name = "mode_paiement", length = 50)
    private String modePaiement;

    // Getters et Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getIdEmploye() { return idEmploye; }
    public void setIdEmploye(Integer idEmploye) { this.idEmploye = idEmploye; }
    public LocalDate getDatePaie() { return datePaie; }
    public void setDatePaie(LocalDate datePaie) { this.datePaie = datePaie; }
    public LocalDate getPeriodeDebut() { return periodeDebut; }
    public void setPeriodeDebut(LocalDate periodeDebut) { this.periodeDebut = periodeDebut; }
    public LocalDate getPeriodeFin() { return periodeFin; }
    public void setPeriodeFin(LocalDate periodeFin) { this.periodeFin = periodeFin; }
    public BigDecimal getSalaireBase() { return salaireBase; }
    public void setSalaireBase(BigDecimal salaireBase) { this.salaireBase = salaireBase; }
    public BigDecimal getHeuresSupNormales() { return heuresSupNormales; }
    public void setHeuresSupNormales(BigDecimal heuresSupNormales) { this.heuresSupNormales = heuresSupNormales; }
    public BigDecimal getHeuresSupWeekend() { return heuresSupWeekend; }
    public void setHeuresSupWeekend(BigDecimal heuresSupWeekend) { this.heuresSupWeekend = heuresSupWeekend; }
    public BigDecimal getPrimeAnciennete() { return primeAnciennete; }
    public void setPrimeAnciennete(BigDecimal primeAnciennete) { this.primeAnciennete = primeAnciennete; }
    public BigDecimal getAbsences() { return absences; }
    public void setAbsences(BigDecimal absences) { this.absences = absences; }
    public BigDecimal getAutresPrimes() { return autresPrimes; }
    public void setAutresPrimes(BigDecimal autresPrimes) { this.autresPrimes = autresPrimes; }
    public BigDecimal getSalaireBrut() { return salaireBrut; }
    public void setSalaireBrut(BigDecimal salaireBrut) { this.salaireBrut = salaireBrut; }
    public BigDecimal getRetenueCnaps() { return retenueCnaps; }
    public void setRetenueCnaps(BigDecimal retenueCnaps) { this.retenueCnaps = retenueCnaps; }
    public BigDecimal getRetenueOstie() { return retenueOstie; }
    public void setRetenueOstie(BigDecimal retenueOstie) { this.retenueOstie = retenueOstie; }
    public BigDecimal getRetenueIrsa() { return retenueIrsa; }
    public void setRetenueIrsa(BigDecimal retenueIrsa) { this.retenueIrsa = retenueIrsa; }
    public BigDecimal getTotalRetenues() { return totalRetenues; }
    public void setTotalRetenues(BigDecimal totalRetenues) { this.totalRetenues = totalRetenues; }
    public BigDecimal getNetAPayer() { return netAPayer; }
    public void setNetAPayer(BigDecimal netAPayer) { this.netAPayer = netAPayer; }
    public String getModePaiement() { return modePaiement; }
    public void setModePaiement(String modePaiement) { this.modePaiement = modePaiement; }
}