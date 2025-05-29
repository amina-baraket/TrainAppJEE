package com.trainapp.dao;

import com.trainapp.model.User;
import com.trainapp.util.JPAUtil;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import java.util.List;

public class Userdao {
    
    // Compte admin par défaut
    private static final String DEFAULT_ADMIN_EMAIL = "admin@trainapp.com";
    private static final String DEFAULT_ADMIN_PASSWORD = "admin123";
    
    public Userdao() {
        createDefaultAdminIfNotExists();
    }
    
    private void createDefaultAdminIfNotExists() {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            TypedQuery<User> query = em.createQuery(
                "SELECT u FROM User u WHERE u.email = :email", 
                User.class);
            query.setParameter("email", DEFAULT_ADMIN_EMAIL);
            
            List<User> results = query.getResultList();
            if (results.isEmpty()) {
                // Créer le compte admin par défaut
                User admin = new User("Admin", "System", DEFAULT_ADMIN_EMAIL, DEFAULT_ADMIN_PASSWORD);
                admin.setRole("ADMIN");
                admin.setActive(true);
                
                transaction.begin();
                em.persist(admin);
                transaction.commit();
            } else {
                // S'assurer que le compte admin existant est actif
                User admin = results.get(0);
                if (!admin.isActive() || !"ADMIN".equals(admin.getRole())) {
                    transaction.begin();
                    admin.setActive(true);
                    admin.setRole("ADMIN");
                    em.merge(admin);
                    transaction.commit();
                }
            }
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }
    
    public User checkLogin(String email, String password) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<User> query = em.createQuery(
                "SELECT u FROM User u WHERE u.email = :email AND u.password = :password", 
                User.class);
            query.setParameter("email", email);
            query.setParameter("password", password);
            
            List<User> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }
    
    public void save(User user) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            user.setDateInscription(new java.util.Date());
            em.persist(user);
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
    
    public void update(User user) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            em.merge(user);
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
    
    public User getById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(User.class, id);
        } finally {
            em.close();
        }
    }
    
    public List<User> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<User> query = em.createQuery("SELECT u FROM User u", User.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public long count() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(u) FROM User u", Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}
