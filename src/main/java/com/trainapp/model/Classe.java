package com.trainapp.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "classes")
public class Classe {
    @Id
    @GeneratedValue
    private int id;
    
    private String nom; // "Première", "Deuxième", "Économique"
    private double coefficientPrix; // Multiplicateur du prix de base
    private int nombrePlaces; // Nombre total de places dans cette classe
    private String description;
    
    // Constructeurs
    public Classe() {}
    
    public Classe(String nom, double coefficientPrix, int nombrePlaces, String description) {
        this.nom = nom;
        this.coefficientPrix = coefficientPrix;
        this.nombrePlaces = nombrePlaces;
        this.description = description;
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
    
    public double getCoefficientPrix() {
        return coefficientPrix;
    }
    
    public void setCoefficientPrix(double coefficientPrix) {
        this.coefficientPrix = coefficientPrix;
    }
    
    public int getNombrePlaces() {
        return nombrePlaces;
    }
    
    public void setNombrePlaces(int nombrePlaces) {
        this.nombrePlaces = nombrePlaces;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
} 