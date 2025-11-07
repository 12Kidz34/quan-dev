package com.java04.service;

import com.java04.entity.Users;
import com.java04.utils.XJPA;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import java.util.List;

public class UsersDAOImpl implements UsersDAO{
    EntityManager em = XJPA.getEntityManager();
    protected void finaly() throws Throwable {
        em.close();
    }
    @Override
    public List<Users> findAll() {
        String jpql = "SELECT o FROM Users o";
        TypedQuery<Users> query = em.createQuery(jpql, Users.class);
        return query.getResultList();
    }

    @Override
    public Users findById(String id) {
        return em.find(Users.class, id);
    }

    @Override
    public void create(Users entity) {
        try {
            em.getTransaction().begin();
            em.persist(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }

    @Override
    public void update(Users entity) {
        try {
            em.getTransaction().begin();
            em.merge(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }

    @Override
    public void deleteById(String id) {
        Users entity = em.find(Users.class, id);
        try {
            em.getTransaction().begin();
            em.remove(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }

    @Override
    public Users findByIdOrEmail(String userinfo) {
        String jpql = "select u from Users u where u.id = :info or u.email = :info";
        TypedQuery<Users> query = em.createQuery(jpql, Users.class);
        try {
            query.setParameter("info", userinfo);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
}
