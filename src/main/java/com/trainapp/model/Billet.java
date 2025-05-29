package com.trainapp.model;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "billets")
public class Billet {
    @Id 
    @GeneratedValue
    private int id;

    @ManyToOne
    private User user;

    @ManyToOne
    private Trajet trajet;

    @ManyToOne
    private Classe classe;

    @ManyToMany
    @JoinTable(
        name = "billet_preferences",
        joinColumns = @JoinColumn(name = "billet_id"),
        inverseJoinColumns = @JoinColumn(name = "preference_id")
    )
    private Set<Preference> preferences = new HashSet<>();

    public enum Statut {
        ACHETE,
        UTILISE,
        ANNULE,
        EN_ATTENTE_ANNULATION
    }

    @Enumerated(EnumType.STRING)
    private Statut statut;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dateAchat;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dateModification;

    private double prixFinal;
    private String numeroSiege;
    private String commentaire;

    // Constructeurs
    public Billet() {
        this.dateAchat = new Date();
        this.statut = Statut.ACHETE;
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Trajet getTrajet() {
        return trajet;
    }

    public void setTrajet(Trajet trajet) {
        this.trajet = trajet;
    }

    public Classe getClasse() {
        return classe;
    }

    public void setClasse(Classe classe) {
        this.classe = classe;
    }

    public Set<Preference> getPreferences() {
        return preferences;
    }

    public void setPreferences(Set<Preference> preferences) {
        this.preferences = preferences;
    }

    public void addPreference(Preference preference) {
        this.preferences.add(preference);
    }

    public void removePreference(Preference preference) {
        this.preferences.remove(preference);
    }

    public Statut getStatut() {
        return statut;
    }

    public void setStatut(Statut statut) {
        this.statut = statut;
        this.dateModification = new Date();
    }

    public Date getDateAchat() {
        return dateAchat;
    }

    public void setDateAchat(Date dateAchat) {
        this.dateAchat = dateAchat;
    }

    public Date getDateModification() {
        return dateModification;
    }

    public void setDateModification(Date dateModification) {
        this.dateModification = dateModification;
    }

    public double getPrixFinal() {
        return prixFinal;
    }

    public void setPrixFinal(double prixFinal) {
        this.prixFinal = prixFinal;
    }

    public String getNumeroSiege() {
        return numeroSiege;
    }

    public void setNumeroSiege(String numeroSiege) {
        this.numeroSiege = numeroSiege;
    }

    public String getCommentaire() {
        return commentaire;
    }

    public void setCommentaire(String commentaire) {
        this.commentaire = commentaire;
    }
}
