package com.trainapp.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;

import com.trainapp.model.Voyage;
import com.trainapp.util.JPAUtil;

public class VoyageDAO {
    
    public void save(Voyage voyage) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            em.persist(voyage);
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
    
    public void update(Voyage voyage) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            em.merge(voyage);
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
    
    public Voyage getById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Voyage.class, id);
        } finally {
            em.close();
        }
    }
    
    public List<Voyage> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Voyage> query = em.createQuery("SELECT v FROM Voyage v", Voyage.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public long count() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(v) FROM Voyage v", Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
    
    public void delete(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            Voyage voyage = em.find(Voyage.class, id);
            if (voyage != null) {
                em.remove(voyage);
            }
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
}
