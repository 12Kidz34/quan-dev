package com.java04.service;

import com.java04.entity.Favorite;

import java.util.List;

public interface FavoriteDAO {
    List<Favorite> findAll();

    Favorite findById(Long id);

    void create(Favorite item);

    void update(Favorite item);

    void deleteById(Long id);

    List<Favorite> findByUserId(String userId);

    List<Object[]> getVideoFavoritesSummary();

    List<Favorite> getUsersByVideoId(String videoId);
}

