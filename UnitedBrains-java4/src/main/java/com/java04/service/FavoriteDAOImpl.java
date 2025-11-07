package com.java04.service;

import com.java04.entity.Favorite;
import com.java04.utils.XJPA;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.List;

public class FavoriteDAOImpl implements FavoriteDAO {
    EntityManager em = XJPA.getEntityManager();
    protected void finaly() throws Throwable {
        em.close();
    }
    @Override
    public List<Favorite> findAll() {
        String jpql = "SELECT o FROM Favorite o";
        TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
        return query.getResultList();
    }

    @Override
    public Favorite findById(Long id) {
        return em.find(Favorite.class, id);
    }

    @Override
    public void create(Favorite entity) {
        try {
            em.getTransaction().begin();
            em.persist(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }

    @Override
    public void update(Favorite entity) {
        try {
            em.getTransaction().begin();
            em.merge(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }

    @Override
    public void deleteById(Long id) {
        Favorite entity = em.find(Favorite.class, id);
        try {
            em.getTransaction().begin();
            em.remove(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }

    @Override
    public List<Favorite> findByUserId(String userId) {
        String jpql = "SELECT f FROM Favorite f WHERE f.user.id = :userId";
        return em.createQuery(jpql, Favorite.class)
                .setParameter("userId", userId)
                .getResultList();
    }

    @Override
    public List<Object[]> getVideoFavoritesSummary() {
        String jpql = "SELECT f.video.title, " +
                "COUNT(f), " +
                "MAX(f.likeDate), " +
                "MIN(f.likeDate) " +
                "FROM Favorite f " +
                "GROUP BY f.video.title";
        return em.createQuery(jpql, Object[].class).getResultList();
    }

    @Override
    public List<Favorite> getUsersByVideoId(String videoId) {
        String jpql = "FROM Favorite f WHERE f.video.id = :vid";
        return em.createQuery(jpql, Favorite.class)
                .setParameter("vid", videoId)
                .getResultList();
    }
}

