package com.poly.dao.impl;

import com.poly.dao.RoleDAO;
import com.poly.entity.Role;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Transactional
public class RoleDAOImpl implements RoleDAO {

    @PersistenceContext
    private EntityManager em;

    @Override
    public List<Role> findAll() {
        return em.createQuery("SELECT r FROM Role r", Role.class).getResultList();
    }

    @Override
    public Role findById(String id) {
        return em.find(Role.class, id);
    }

    @Override
    public void save(Role role) {
        if (findById(role.getId()) == null) {
            em.persist(role);
        } else {
            em.merge(role);
        }
    }

    @Override
    public void deleteById(String id) {
        Role role = findById(id);
        if (role != null) {
            em.remove(role);
        }
    }
}
