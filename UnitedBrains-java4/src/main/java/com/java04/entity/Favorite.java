package com.java04.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="Favorite")
public class Favorite {
    @Id
    @Column(name="id")
    private Long id;
    @ManyToOne
    @JoinColumn(name="userId")
    private Users user;
    @ManyToOne
    @JoinColumn(name="videoId")
    private Video video;
    @Column(name="likeDate")
    private Date likeDate;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Users getUser() {
        return user;
    }

    public void setUser(Users user) {
        this.user = user;
    }

    public Video getVideo() {
        return video;
    }

    public void setVideo(Video video) {
        this.video = video;
    }

    public Date getLikeDate() {
        return likeDate;
    }

    public void setLikeDate(Date likeDate) {
        this.likeDate = likeDate;
    }
}

