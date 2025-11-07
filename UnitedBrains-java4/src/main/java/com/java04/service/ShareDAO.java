package com.java04.service;

import com.java04.entity.Share;

import java.util.List;

public interface ShareDAO {
    List<Share> findAll();

    Share findById(Long id);

    void create(Share item);

    void update(Share item);

    void deleteById(Long id);

    List<Object[]> getShareVideoInfo();

    List<Share> getUsersByVideoId(String videoId);
}
