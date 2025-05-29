package com.trainapp.test;

import javax.persistence.*;

public class HibernateTest {
    public static void main(String[] args) {
        try {
            System.out.println(">>> Initialisation de Hibernate...");
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("myPU");
            EntityManager em = emf.createEntityManager();

            System.out.println(">>> Hibernate initialisé avec succès.");

            em.close();
            emf.close();
        } catch (Exception e) {
            System.err.println("Erreur lors de l'initialisation d'Hibernate : " + e.getMessage());
            e.printStackTrace();
        }
    }
}
