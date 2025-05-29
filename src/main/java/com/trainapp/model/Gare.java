package com.trainapp.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

@Entity
@Table(name = "gares", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"nom", "ville"})
})
public class Gare {
    @Id
    @GeneratedValue
    private int id;
    
    @Column(nullable = false)
    private String nom;
    
    @Column(nullable = false)
    private String ville;
    
    @Column(nullable = false)
    private String adresse;
    
    @Column(nullable = false)
    private String codePostal;
    
    @Column(nullable = false)
    private String pays;
    
    private boolean active;
    
    // Constructeurs
    public Gare() {
        this.active = true;
    }
    
    public Gare(String nom, String ville, String adresse, String codePostal, String pays) {
        this.nom = nom;
        this.ville = ville;
        this.adresse = adresse;
        this.codePostal = codePostal;
        this.pays = pays;
        this.active = true;
    }
    
    // Getters et Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getNom() {
        return nom;
    }
    
    public void setNom(String nom) {
        this.nom = nom;
    }
    
    public String getVille() {
        return ville;
    }
    
    public void setVille(String ville) {
        this.ville = ville;
    }
    
    public String getAdresse() {
        return adresse;
    }
    
    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }
    
    public String getCodePostal() {
        return codePostal;
    }
    
    public void setCodePostal(String codePostal) {
        this.codePostal = codePostal;
    }
    
    public String getPays() {
        return pays;
    }
    
    public void setPays(String pays) {
        this.pays = pays;
    }
    
    public boolean isActive() {
        return active;
    }
    
    public void setActive(boolean active) {
        this.active = active;
    }
} 