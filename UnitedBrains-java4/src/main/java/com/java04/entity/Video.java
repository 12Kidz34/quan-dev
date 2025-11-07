package com.java04.entity;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name="Video")
public class Video {
    @Id
    @Column(name="id")
    private String id;

    @Column(name="title")
    private String title;

    @Column(name="poster")
    private String poster;

    @Column(name="views")
    private Integer views;

    @Column(name="description")
    private String description;

    @Column(name="active")
    private Boolean active = false;

    @Column(name="link")
    private String link;

    @OneToMany(mappedBy = "video")
    private List<Favorite> favorites;

    @OneToMany(mappedBy = "video")
    private List<Share> shares;

    // ✅ Bắt buộc JPA: constructor mặc định
    public Video() {
    }

    // ✅ Thêm constructor tiện cho test (tuỳ chọn)
    public Video(String id) {
        this.id = id;
    }

    // Getters & Setters...

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public Integer getViews() {
        return views;
    }

    public void setViews(Integer views) {
        this.views = views;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public List<Favorite> getFavorites() {
        return favorites;
    }

    public void setFavorites(List<Favorite> favorites) {
        this.favorites = favorites;
    }

    public List<Share> getShares() {
        return shares;
    }

    public void setShares(List<Share> shares) {
        this.shares = shares;
    }
}

