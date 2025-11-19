package com.poly.dao;

import com.poly.entity.User;
import java.util.List;

public interface UserDAO {
    List<User> findAll();
    User findByUsername(String username);
    void save(User user);
    void deleteByUsername(String username);
}
