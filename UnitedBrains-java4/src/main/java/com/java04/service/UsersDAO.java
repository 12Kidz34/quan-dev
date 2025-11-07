package com.java04.service;

import com.java04.entity.Users;

import java.util.List;

public interface UsersDAO {
    List<Users> findAll();

    Users findById(String id);

    void create(Users item);

    void update(Users item);

    void deleteById(String id);

    Users findByIdOrEmail(String idoremail);
}
