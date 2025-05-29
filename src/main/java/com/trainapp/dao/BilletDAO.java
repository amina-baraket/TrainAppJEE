package com.trainapp.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.trainapp.model.Billet;
import com.trainapp.model.User;
import com.trainapp.util.HibernateUtil;
import com.trainapp.util.JPAUtil;

public class BilletDAO {

    // ✅ Récupérer un billet par ID
    public Billet getBilletById(int billetId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Billet.class, billetId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // ✅ Ajouter un nouveau billet
    public void ajouterBillet(Billet billet) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.save(billet);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }

    // ✅ Mettre à jour un billet
    public void updateBillet(Billet billet) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.update(billet);
            tx.commit();
        }
    }

    // ✅ Marquer comme annulé
    public void demanderAnnulation(int billetId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            Billet billet = session.get(Billet.class, billetId);
            billet.setStatut(Billet.Statut.ANNULE);
            session.update(billet);
            tx.commit();
        }
    }

    // ✅ Récupérer les billets utilisés par un utilisateur
    public List<Billet> getBilletsUtilisesByUser(User user) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Billet> query = session.createQuery(
            		"FROM Billet WHERE user = :user AND statut = 'utilisé'", Billet.class);
            query.setParameter("user", user);
            return query.list();
        }
    }

    // ✅ Récupérer tous les billets d'un utilisateur
    public List<Billet> getBilletsByUser(User user) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Billet> query = session.createQuery(
                "FROM Billet b JOIN FETCH b.preferences WHERE b.user = :user", Billet.class);
            query.setParameter("user", user);
            return query.list();
        }
    }

    // ✅ Récupérer tous les billets
    public List<Billet> getAllBillets() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Billet", Billet.class).list();
        }
    }

    // ✅ Supprimer un billet
    public void deleteBillet(int billetId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            Billet billet = session.get(Billet.class, billetId);
            if (billet != null) {
                session.delete(billet);
                tx.commit();
            }
        }
    }

    public void save(Billet billet) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            em.persist(billet);
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
    
    public void update(Billet billet) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            em.merge(billet);
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
    
    public Billet getById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Billet.class, id);
        } finally {
            em.close();
        }
    }
    
    public List<Billet> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Billet> query = em.createQuery("SELECT b FROM Billet b", Billet.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public long count() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(b) FROM Billet b", Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}
