package com.trainapp.dao;

import java.sql.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;

import com.trainapp.model.Gare;
import com.trainapp.model.Trajet;
import com.trainapp.util.JPAUtil;

public class TrajetDAO {

    // Rechercher un trajet par départ et destination
    public List<Trajet> rechercherTrajets(String depart, String destination) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Trajet> query = em.createQuery(
                "SELECT t FROM Trajet t WHERE t.depart = :dep AND t.destination = :dest", 
                Trajet.class);
            query.setParameter("dep", depart);
            query.setParameter("dest", destination);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // Trouver un trajet par son ID
    public Trajet findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Trajet.class, id);
        } finally {
            em.close();
        }
    }

    // Mettre à jour un trajet
    public void updateTrajet(Trajet trajet) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            em.merge(trajet);
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

    // Rechercher des trajets par date, départ et destination
    public List<Trajet> rechercherTrajetsParDateDepartDepartDestination(Date dateDepart, String depart, String destination) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Trajet> query = em.createQuery(
                "SELECT t FROM Trajet t WHERE t.date_depart = :dateDep AND t.depart = :dep AND t.destination = :dest", 
                Trajet.class);
            query.setParameter("dateDep", dateDepart);
            query.setParameter("dep", depart);
            query.setParameter("dest", destination);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // Ajouter un nouveau trajet
    public void saveTrajet(Trajet trajet) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            em.persist(trajet);
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

    // Récupérer tous les trajets
    public List<Trajet> getAllTrajets() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Trajet> query = em.createQuery("SELECT t FROM Trajet t", Trajet.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // Supprimer un trajet
    public void deleteTrajet(int trajetId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        
        try {
            transaction.begin();
            Trajet trajet = em.find(Trajet.class, trajetId);
            if (trajet != null) {
                em.remove(trajet);
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

    // Rechercher des trajets par date, départ et destination (par IDs de gare)
    public List<Trajet> rechercherTrajetsParDateEtGares(Date dateDepart, int departId, int destinationId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            // Récupérer les noms des gares à partir des IDs
            GareDAO gareDAO = new GareDAO();
            Gare gareDepart = gareDAO.getById(departId);
            Gare gareDestination = gareDAO.getById(destinationId);

            // Vérifier si les gares existent
            if (gareDepart == null || gareDestination == null) {
                // Gérer ce cas, peut-être lancer une exception ou retourner une liste vide
                System.out.println("Gare de départ ou de destination non trouvée pour IDs: " + departId + ", " + destinationId); // Debug print
                return new java.util.ArrayList<>();
            }

            String departNom = gareDepart.getNom();
            String destinationNom = gareDestination.getNom();
            
            System.out.println("Recherche trajets avec Date: " + dateDepart + ", Départ: " + departNom + ", Destination: " + destinationNom); // Debug print

            TypedQuery<Trajet> query = em.createQuery(
                "SELECT t FROM Trajet t WHERE t.date_depart = :date AND t.depart = :departNom AND t.destination = :destinationNom", 
                Trajet.class);
            query.setParameter("date", dateDepart);
            query.setParameter("departNom", gareDepart.getVille());
            query.setParameter("destinationNom", gareDestination.getVille());
            
            List<Trajet> resultList = query.getResultList();
            System.out.println("Nombre de trajets trouvés : " + resultList.size()); // Debug print

            return resultList;
        } finally {
            em.close();
        }
    }
}
