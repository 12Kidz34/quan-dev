
package com.java04.utils;


import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class XJPA {
    private static EntityManagerFactory factory;
    static {
        factory = Persistence.createEntityManagerFactory("myPersistenceUnit");
    }
    public static EntityManager getEntityManager(){
        return factory.createEntityManager();
    }
}


