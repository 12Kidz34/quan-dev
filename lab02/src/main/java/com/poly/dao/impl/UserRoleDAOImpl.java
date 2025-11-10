package com.poly.dao.impl;

import com.poly.dao.UserRoleDAO;
import com.poly.entity.UserRole;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Transactional
public class UserRoleDAOImpl implements UserRoleDAO {

    @PersistenceContext
    private EntityManager em;

    @Override
    public List<UserRole> findAll() {
        return em.createQuery("SELECT ur FROM UserRole ur", UserRole.class).getResultList();
    }

    @Override
    public List<UserRole> findByUsername(String username) {
        return em.createQuery("SELECT ur FROM UserRole ur WHERE ur.user.username = :username", UserRole.class)
                .setParameter("username", username)
                .getResultList();
    }

    @Override
    public void save(UserRole userRole) {
        if (userRole.getId() == null) {
            em.persist(userRole);
        } else {
            em.merge(userRole);
        }
    }

    @Override
    public void deleteById(Long id) {
        UserRole ur = em.find(UserRole.class, id);
        if (ur != null) {
            em.remove(ur);
        }
    }
}
