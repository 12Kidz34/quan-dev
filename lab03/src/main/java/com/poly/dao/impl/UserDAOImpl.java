package com.poly.dao.impl;

import com.poly.dao.UserDAO;
import com.poly.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Transactional
public class UserDAOImpl implements UserDAO {

    @PersistenceContext
    private EntityManager em;

    @Override
    public List<User> findAll() {
        return em.createQuery("SELECT u FROM User u", User.class).getResultList();
    }

    @Override
    public User findByUsername(String username) {
        return em.find(User.class, username);
    }

    @Override
    public void save(User user) {
        if (findByUsername(user.getUsername()) == null) {
            em.persist(user);
        } else {
            em.merge(user);
        }
    }

    @Override
    public void deleteByUsername(String username) {
        User user = findByUsername(username);
        if (user != null) {
            em.remove(user);
        }
    }
}
