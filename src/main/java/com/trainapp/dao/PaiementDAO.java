package com.trainapp.dao;

import com.trainapp.model.Paiement;
import com.trainapp.model.Billet;
import com.trainapp.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import java.util.List;
import com.trainapp.util.JPAUtil;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;

public class PaiementDAO {

    // ✅ Ajouter un paiement avec un billet lié
    public void ajouterPaiementAvecBillet(Paiement paiement, Billet billet) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.save(billet);
            session.save(paiement);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }

    // ✅ Obtenir tous les paiements d'un utilisateur
    public List<Paiement> getPaiementsParUserId(Long userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Paiement WHERE user.id = :userId", Paiement.class)
                          .setParameter("userId", userId)
                          .list();
        }
    }

    // ✅ Trouver un paiement par ID
    public Paiement getPaiementById(int id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Paiement.class, id);
        }
    }

    public void save(Paiement paiement) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            em.persist(paiement);
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
    
    public void update(Paiement paiement) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            em.merge(paiement);
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
    
    public Paiement getById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Paiement.class, id);
        } finally {
            em.close();
        }
    }
    
    public List<Paiement> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Paiement> query = em.createQuery("SELECT p FROM Paiement p", Paiement.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public List<Paiement> getByStatut(String statut) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Paiement> query = em.createQuery(
                "SELECT p FROM Paiement p WHERE p.statut = :statut", 
                Paiement.class);
            query.setParameter("statut", statut);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
