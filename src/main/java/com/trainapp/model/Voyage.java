package com.trainapp.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="voyage")
public class Voyage {
	@Id @GeneratedValue

    private int id;
    private int trajetId;
    private String dateVoyage;

    public Voyage() {}

    public Voyage(int trajetId, String dateVoyage) {
        this.trajetId = trajetId;
        this.dateVoyage = dateVoyage;
    }

    public Voyage(int id, int trajetId, String dateVoyage) {
        this.id = id;
        this.trajetId = trajetId;
        this.dateVoyage = dateVoyage;
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTrajetId() {
        return trajetId;
    }

    public void setTrajetId(int trajetId) {
        this.trajetId = trajetId;
    }

    public String getDateVoyage() {
        return dateVoyage;
    }

    public void setDateVoyage(String dateVoyage) {
        this.dateVoyage = dateVoyage;
    }
}