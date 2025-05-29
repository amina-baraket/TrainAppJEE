package com.trainapp.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "demandes_annulation")
public class DemandeAnnulation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @ManyToOne
    @JoinColumn(name = "billet_id", nullable = false)
    private Billet billet;
    
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    
    @Column(nullable = false)
    private String motif;
    
    @Column(name = "date_demande", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateDemande;
    
    @Column(name = "date_traitement")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateTraitement;
    
    @Column(nullable = false)
    private String statut; // EN_ATTENTE, ACCEPTEE, REFUSEE
    
    @Column(name = "commentaire_admin")
    private String commentaireAdmin;
    
    public DemandeAnnulation() {
        this.dateDemande = new Date();
        this.statut = "EN_ATTENTE";
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public Billet getBillet() {
        return billet;
    }
    
    public void setBillet(Billet billet) {
        this.billet = billet;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    public String getMotif() {
        return motif;
    }
    
    public void setMotif(String motif) {
        this.motif = motif;
    }
    
    public Date getDateDemande() {
        return dateDemande;
    }
    
    public void setDateDemande(Date dateDemande) {
        this.dateDemande = dateDemande;
    }
    
    public Date getDateTraitement() {
        return dateTraitement;
    }
    
    public void setDateTraitement(Date dateTraitement) {
        this.dateTraitement = dateTraitement;
    }
    
    public String getStatut() {
        return statut;
    }
    
    public void setStatut(String statut) {
        this.statut = statut;
    }
    
    public String getCommentaireAdmin() {
        return commentaireAdmin;
    }
    
    public void setCommentaireAdmin(String commentaireAdmin) {
        this.commentaireAdmin = commentaireAdmin;
    }
} 