package com.java04.service;

import com.java04.entity.Share;
import com.java04.utils.XJPA;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import java.util.List;

public class ShareDAOImpl implements ShareDAO {

    @Override
    public List<Share> findAll() {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT o FROM Share o";
            TypedQuery<Share> query = em.createQuery(jpql, Share.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Share findById(Long id) {
        if (id == null) return null;
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.find(Share.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public void create(Share entity) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(entity);
            em.flush(); // 🔸 đảm bảo ID được sinh ngay lập tức
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx.isActive()) tx.rollback();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Share entity) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(entity);
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx.isActive()) tx.rollback();
        } finally {
            em.close();
        }
    }

    @Override
    public void deleteById(Long id) {
        if (id == null) {
            System.out.println("⚠ deleteById được gọi với id = null");
            return;
        }
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Share entity = em.find(Share.class, id);
            if (entity != null) {
                em.remove(entity);
            } else {
                System.out.println("⚠ Không tìm thấy Share với id = " + id);
            }
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (tx.isActive()) tx.rollback();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Object[]> getShareVideoInfo() {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT s.video.title, COUNT(s), MIN(s.shareDate), MAX(s.shareDate) " +
                    "FROM Share s GROUP BY s.video.title";
            TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Share> getUsersByVideoId(String videoId) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "FROM Share s WHERE s.video.id = :vid";
            return em.createQuery(jpql, Share.class)
                    .setParameter("vid", videoId)
                    .getResultList();
        } finally {
            em.close();
        }
    }
}
