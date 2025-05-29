package com.trainapp.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "voyages_consecutifs")
public class VoyageConsecutif {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @ManyToOne
    @JoinColumn(name = "voyage_initial_id")
    private Voyage voyageInitial;
    
    @ManyToOne
    @JoinColumn(name = "voyage_suivant_id")
    private Voyage voyageSuivant;
    
    private int dureeAttente; // en minutes
    private boolean actif;
    
    public VoyageConsecutif() {
        this.actif = true;
    }
    
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public Voyage getVoyageInitial() {
        return voyageInitial;
    }
    
    public void setVoyageInitial(Voyage voyageInitial) {
        this.voyageInitial = voyageInitial;
    }
    
    public Voyage getVoyageSuivant() {
        return voyageSuivant;
    }
    
    public void setVoyageSuivant(Voyage voyageSuivant) {
        this.voyageSuivant = voyageSuivant;
    }
    
    public int getDureeAttente() {
        return dureeAttente;
    }
    
    public void setDureeAttente(int dureeAttente) {
        this.dureeAttente = dureeAttente;
    }
    
    public boolean isActif() {
        return actif;
    }
    
    public void setActif(boolean actif) {
        this.actif = actif;
    }
} 