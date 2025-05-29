package com.trainapp.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;

import com.trainapp.model.Voyage;
import com.trainapp.model.VoyageConsecutif;
import com.trainapp.util.JPAUtil;

public class VoyageConsecutifDAO {
    
    public void save(VoyageConsecutif voyageConsecutif) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction et = em.getTransaction();
        
        try {
            et.begin();
            em.persist(voyageConsecutif);
            et.commit();
        } catch (Exception e) {
            if (et != null && et.isActive()) {
                et.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }
    
    public void update(VoyageConsecutif voyageConsecutif) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction et = em.getTransaction();
        
        try {
            et.begin();
            em.merge(voyageConsecutif);
            et.commit();
        } catch (Exception e) {
            if (et != null && et.isActive()) {
                et.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }
    
    public void delete(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction et = em.getTransaction();
        
        try {
            et.begin();
            VoyageConsecutif voyageConsecutif = em.find(VoyageConsecutif.class, id);
            if (voyageConsecutif != null) {
                em.remove(voyageConsecutif);
            }
            et.commit();
        } catch (Exception e) {
            if (et != null && et.isActive()) {
                et.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }
    
    public VoyageConsecutif getById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(VoyageConsecutif.class, id);
        } finally {
            em.close();
        }
    }
    
    @SuppressWarnings("unchecked")
    public List<VoyageConsecutif> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            // Eagerly fetch associated Voyages and Gares
            Query query = em.createQuery("SELECT vc FROM VoyageConsecutif vc JOIN FETCH vc.voyageInitial vi JOIN FETCH vi.gareDepart JOIN FETCH vi.gareArrivee JOIN FETCH vc.voyageSuivant vs JOIN FETCH vs.gareDepart JOIN FETCH vs.gareArrivee");
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    @SuppressWarnings("unchecked")
    public List<VoyageConsecutif> getByVoyageInitial(Voyage voyage) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Query query = em.createQuery("SELECT vc FROM VoyageConsecutif vc WHERE vc.voyageInitial = :voyage AND vc.actif = true");
            query.setParameter("voyage", voyage);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    @SuppressWarnings("unchecked")
    public List<VoyageConsecutif> getActifs() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Query query = em.createQuery("SELECT vc FROM VoyageConsecutif vc WHERE vc.actif = true");
            return query.getResultList();
        } finally {
            em.close();
        }
    }
} 