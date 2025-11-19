package com.poly.dao;

import com.poly.entity.Role;
import java.util.List;

public interface RoleDAO {
    List<Role> findAll();
    Role findById(String id);
    void save(Role role);
    void deleteById(String id);
}
