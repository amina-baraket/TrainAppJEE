package com.trainapp.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;

import com.trainapp.model.Preference;
import com.trainapp.util.JPAUtil;

public class PreferenceDAO {
    
    public void save(Preference preference) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            em.persist(preference);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace(); // Log the exception
             throw new RuntimeException("Erreur lors de la sauvegarde de la préférence", e); // Rethrow as runtime exception
        } finally {
            em.close();
        }
    }
    
    public void update(Preference preference) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            em.merge(preference);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace(); // Log the exception
             throw new RuntimeException("Erreur lors de la mise à jour de la préférence", e); // Rethrow as runtime exception
        } finally {
            em.close();
        }
    }
    
    public void delete(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            Preference preference = em.find(Preference.class, id);
            if (preference != null) {
                em.remove(preference);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace(); // Log the exception
             throw new RuntimeException("Erreur lors de la suppression de la préférence", e); // Rethrow as runtime exception
        } finally {
            em.close();
        }
    }
    
    public Preference getById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Preference.class, id);
        } finally {
            em.close();
        }
    }
    
    public List<Preference> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Preference> query = em.createQuery("SELECT p FROM Preference p", Preference.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public Preference getByCode(String code) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Preference> query = em.createQuery("SELECT p FROM Preference p WHERE p.code = :code", Preference.class);
            query.setParameter("code", code);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
    
    public List<Preference> getDisponibles() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Preference> query = em.createQuery("SELECT p FROM Preference p WHERE p.disponible = true", Preference.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
} 