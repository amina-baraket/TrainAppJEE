package com.trainapp.model;

import java.sql.Date;
import java.sql.Time;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="trajets")
public class Trajet {
	@Id @GeneratedValue
    private int id;
    public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDepart() {
		return depart;
	}
	public void setDepart(String depart) {
		this.depart = depart;
	}
	public String getDestination() {
		return destination;
	}
	public void setDestination(String destination) {
		this.destination = destination;
	}
	public Date getDate_depart() {
		return date_depart;
	}
	public void setDate_depart(Date date_depart) {
		this.date_depart = date_depart;
	}
	public Time getHeure_depart() {
		return heure_depart;
	}
	public void setHeure_depart(Time heure_depart) {
		this.heure_depart = heure_depart;
	}
	public Time getHeure_arrivee() {
		return heure_arrivee;
	}
	public void setHeure_arrivee(Time heure_arrivee) {
		this.heure_arrivee = heure_arrivee;
	}
	public double getPrix() {
		return prix;
	}
	public void setPrix(double prix) {
		this.prix = prix;
	}
	public int getPlaces_disponibles() {
		return places_disponibles;
	}
	public void setPlaces_disponibles(int places_disponibles) {
		this.places_disponibles = places_disponibles;
	}
	public double getPromotionPercentage() {
		return promotionPercentage;
	}
	public void setPromotionPercentage(double promotionPercentage) {
		this.promotionPercentage = promotionPercentage;
	}
	private String depart;
    private String destination;
    private Date date_depart;
    private Time heure_depart;
    private Time heure_arrivee;
    private double prix;
    private int places_disponibles;
    private double promotionPercentage = 0.0;
}
