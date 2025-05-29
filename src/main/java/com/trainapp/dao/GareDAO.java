package com.trainapp.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;

import com.trainapp.model.Gare;
import com.trainapp.util.JPAUtil;

public class GareDAO {
    
    public void save(Gare gare) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            // Vérifier si tous les champs requis sont présents
            if (gare.getNom() == null || gare.getNom().trim().isEmpty()) {
                throw new IllegalArgumentException("Le nom de la gare est requis");
            }
            if (gare.getVille() == null || gare.getVille().trim().isEmpty()) {
                throw new IllegalArgumentException("La ville de la gare est requise");
            }
            if (gare.getAdresse() == null || gare.getAdresse().trim().isEmpty()) {
                throw new IllegalArgumentException("L'adresse de la gare est requise");
            }
            if (gare.getCodePostal() == null || gare.getCodePostal().trim().isEmpty()) {
                throw new IllegalArgumentException("Le code postal de la gare est requis");
            }
            if (gare.getPays() == null || gare.getPays().trim().isEmpty()) {
                throw new IllegalArgumentException("Le pays de la gare est requis");
            }
            
            // Vérifier si une gare avec le même nom et la même ville existe déjà
            TypedQuery<Gare> query = em.createQuery(
                "SELECT g FROM Gare g WHERE g.nom = :nom AND g.ville = :ville", 
                Gare.class
            );
            query.setParameter("nom", gare.getNom());
            query.setParameter("ville", gare.getVille());
            
            if (!query.getResultList().isEmpty()) {
                throw new IllegalArgumentException("Une gare avec ce nom existe déjà dans cette ville");
            }
            
            em.persist(gare);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            // Ajouter plus de détails sur l'erreur
            String errorMessage = "Erreur lors de l'ajout de la gare : " + e.getMessage();
            if (e.getCause() != null) {
                errorMessage += " Cause : " + e.getCause().getMessage();
            }
            throw new RuntimeException(errorMessage, e);
        } finally {
            em.close();
        }
    }
    
    public void update(Gare gare) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            em.merge(gare);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }
    
    public void delete(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            Gare gare = em.find(Gare.class, id);
            if (gare != null) {
                em.remove(gare);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace(); // Gérer l'exception de manière appropriée en production
        } finally {
            em.close();
        }
    }
    
    public Gare getById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Gare.class, id);
        } finally {
            em.close();
        }
    }
    
    public List<Gare> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Gare> query = em.createQuery("SELECT g FROM Gare g", Gare.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public List<Gare> getActive() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Gare> query = em.createQuery("SELECT g FROM Gare g WHERE g.active = true", Gare.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public List<Gare> getByVille(String ville) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Gare> query = em.createQuery("SELECT g FROM Gare g WHERE g.ville = :ville", Gare.class);
            query.setParameter("ville", ville);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public Gare getByNom(String nom) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Gare> query = em.createQuery("SELECT g FROM Gare g WHERE g.nom = :nom", Gare.class);
            query.setParameter("nom", nom);
            // For a unique result, use getSingleResult() or handle NoResultException/NonUniqueResultException
            List<Gare> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }
} 