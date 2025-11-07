package com.java04.service;

import com.java04.entity.Video;

import java.util.List;

public interface VideoDAO {
    List<Video> findAll();

    Video findById(String id);

    void create(Video item);

    void update(Video item);

    void deleteById(String id);

    List<Video> findByKeyword(String keyword);

    List<Video> getVideosWithFavorites();

    List<Video> getVideosWithShares();

    void incrementViews(String videoId);
}
