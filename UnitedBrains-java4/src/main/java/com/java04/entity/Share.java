package com.java04.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="Share")
public class Share {
    @Id
    @Column(name="id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    @JoinColumn(name="userId")
    private Users user;
    @ManyToOne
    @JoinColumn(name="videoId")
    private Video video;
    @Column(name="emails")
    private String emails;
    @Column(name="shareDate")
    private Date shareDate;

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

    public String getEmails() {
        return emails;
    }

    public void setEmails(String emails) {
        this.emails = emails;
    }

    public Date getShareDate() {
        return shareDate;
    }

    public void setShareDate(Date shareDate) {
        this.shareDate = shareDate;
    }
}

