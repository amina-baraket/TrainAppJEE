package com.trainapp.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;

import com.trainapp.model.Classe;
import com.trainapp.util.JPAUtil;

public class ClasseDAO {
    
    public void save(Classe classe) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            em.persist(classe);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace(); // Log the exception
            throw new RuntimeException("Erreur lors de la sauvegarde de la classe", e); // Rethrow as runtime exception
        } finally {
            em.close();
        }
    }
    
    public void update(Classe classe) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            em.merge(classe);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace(); // Log the exception
             throw new RuntimeException("Erreur lors de la mise à jour de la classe", e); // Rethrow as runtime exception
        } finally {
            em.close();
        }
    }
    
    public void delete(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            Classe classe = em.find(Classe.class, id);
            if (classe != null) {
                em.remove(classe);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace(); // Log the exception
             throw new RuntimeException("Erreur lors de la suppression de la classe", e); // Rethrow as runtime exception
        } finally {
            em.close();
        }
    }
    
    public Classe getById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Classe.class, id);
        } finally {
            em.close();
        }
    }
    
    public List<Classe> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Classe> query = em.createQuery("SELECT c FROM Classe c", Classe.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public Classe getByNom(String nom) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            System.out.println("Debug: ClasseDAO.getByNom - Searching for nom: " + nom); // Debug print
            TypedQuery<Classe> query = em.createQuery("SELECT c FROM Classe c WHERE c.nom = :nom", Classe.class);
            query.setParameter("nom", nom);
            Classe foundClasse = query.getSingleResult();
            System.out.println("Debug: ClasseDAO.getByNom - Found classe: " + (foundClasse != null ? foundClasse.getNom() : "null")); // Debug print result
            return foundClasse;
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
            System.out.println("Debug: ClasseDAO.getByNom - Exception: " + e.getMessage()); // Debug print exception
            return null; // Return null if not found or error
        } finally {
            em.close();
        }
    }
} 