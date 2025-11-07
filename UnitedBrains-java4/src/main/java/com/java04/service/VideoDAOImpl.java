package com.java04.service;

import com.java04.entity.Video;
import com.java04.utils.XJPA;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.List;
import java.util.NoSuchElementException;

public class VideoDAOImpl implements VideoDAO {
    EntityManager em = XJPA.getEntityManager();
    protected void finaly() throws Throwable {
        em.close();
    }
    @Override
    public List<Video> findAll() {
        String jpql = "SELECT o FROM Video o";
        TypedQuery<Video> query = em.createQuery(jpql, Video.class);
        return query.getResultList();
    }

    @Override
    public Video findById(String id) {
        return em.find(Video.class, id);
    }

    @Override
    public void create(Video entity) {
        try {
            em.getTransaction().begin();
            em.persist(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }

    @Override
    public void update(Video entity) {
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
        Video entity = em.find(Video.class, id);
        try {
            em.getTransaction().begin();
            em.remove(entity);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }

    @Override
    public List<Video> findByKeyword(String keyword) {
        String jpql = "SELECT v FROM Video v where v.title like :keyword";
        TypedQuery<Video> query = em.createQuery(jpql, Video.class);
        try {
            query.setParameter("keyword","%"+ keyword + "%");
            return query.getResultList();
        } catch (NoSuchElementException e) {
            return null;
        }
    }

    @Override
    public List<Video> getVideosWithFavorites() {
        String jpql = "SELECT DISTINCT f.video FROM Favorite f";
        return em.createQuery(jpql, Video.class).getResultList();
    }

    @Override
    public List<Video> getVideosWithShares() {
        String jpql = "SELECT DISTINCT s.video FROM Share s";
        return em.createQuery(jpql, Video.class).getResultList();
    }

    @Override
    public void incrementViews(String videoId) {
        try {
            em.getTransaction().begin();
            Video video = em.find(Video.class, videoId);
            if (video != null) {
                video.setViews(video.getViews() + 1);
                em.merge(video);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        }
    }
}
