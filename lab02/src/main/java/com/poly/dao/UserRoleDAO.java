package com.poly.dao;

import com.poly.entity.UserRole;
import java.util.List;

public interface UserRoleDAO {
    List<UserRole> findAll();
    List<UserRole> findByUsername(String username);
    void save(UserRole userRole);
    void deleteById(Long id);
}
