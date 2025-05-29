package com.trainapp.dao;

import com.trainapp.model.DemandeAnnulation;
import com.trainapp.util.JPAUtil;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import java.util.List;

public class DemandeAnnulationDAO {
    
    public void save(DemandeAnnulation demande) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            em.persist(demande);
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
    
    public void update(DemandeAnnulation demande) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            em.merge(demande);
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
    
    public DemandeAnnulation getById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(DemandeAnnulation.class, id);
        } finally {
            em.close();
        }
    }
    
    public List<DemandeAnnulation> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<DemandeAnnulation> query = em.createQuery(
                "SELECT d FROM DemandeAnnulation d ORDER BY d.dateDemande DESC", 
                DemandeAnnulation.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public List<DemandeAnnulation> getByStatut(String statut) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<DemandeAnnulation> query = em.createQuery(
                "SELECT d FROM DemandeAnnulation d WHERE d.statut = :statut ORDER BY d.dateDemande DESC", 
                DemandeAnnulation.class);
            query.setParameter("statut", statut);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public List<DemandeAnnulation> getByUserId(int userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<DemandeAnnulation> query = em.createQuery(
                "SELECT d FROM DemandeAnnulation d WHERE d.user.id = :userId ORDER BY d.dateDemande DESC", 
                DemandeAnnulation.class);
            query.setParameter("userId", userId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public List<DemandeAnnulation> getByBilletId(int billetId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<DemandeAnnulation> query = em.createQuery(
                "SELECT d FROM DemandeAnnulation d WHERE d.billet.id = :billetId ORDER BY d.dateDemande DESC", 
                DemandeAnnulation.class);
            query.setParameter("billetId", billetId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public long countByStatut(String statut) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(d) FROM DemandeAnnulation d WHERE d.statut = :statut", 
                Long.class);
            query.setParameter("statut", statut);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
} 