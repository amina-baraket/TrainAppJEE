package com.trainapp.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "paiements")
public class Paiement {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private double montant;

    @Temporal(TemporalType.TIMESTAMP)
    private Date datePaiement;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @OneToOne
    @JoinColumn(name = "billet_id")
    private Billet billet;

    @Enumerated(EnumType.STRING)
    private Statut statut = Statut.EN_ATTENTE;

    @Column(length = 500)
    private String commentaire;

    public enum Statut {
        EN_ATTENTE,
        VALIDE,
        REMBOURSE
    }

    // Getters / Setters

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public double getMontant() { return montant; }
    public void setMontant(double montant) { this.montant = montant; }

    public Date getDatePaiement() { return datePaiement; }
    public void setDatePaiement(Date datePaiement) { this.datePaiement = datePaiement; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Billet getBillet() { return billet; }
    public void setBillet(Billet billet) { this.billet = billet; }

    public Statut getStatut() { return statut; }
    public void setStatut(Statut statut) { this.statut = statut; }

    public String getCommentaire() { return commentaire; }
    public void setCommentaire(String commentaire) { this.commentaire = commentaire; }
}
