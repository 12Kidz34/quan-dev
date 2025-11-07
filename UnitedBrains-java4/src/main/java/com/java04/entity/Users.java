package com.java04.entity;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name="Users")
public class Users {
    @Id
    @Column(name="id")
    private String id;

    @Column(name="password")
    private String password;

    @Column(name="fullname")
    private String fullName;

    @Column(name="email")
    private String email;

    @Column(name="admin")
    private Boolean admin = false;

    @OneToMany(mappedBy = "user")
    private List<Favorite> favorites;

    @OneToMany(mappedBy = "user")
    private List<Share> shares;

    // ✅ Bắt buộc JPA: constructor mặc định
    public Users() {
    }

    // ✅ Thêm constructor tiện cho test (tuỳ chọn)
    public Users(String id) {
        this.id = id;
    }

    // Getters & Setters...


    public Boolean getAdmin() {
        return admin;
    }

    public void setAdmin(Boolean admin) {
        this.admin = admin;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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

    public void printInformation(){
        System.out.println("id: "+id);
        System.out.println("password: "+password);
        System.out.println("fullName: "+fullName);
        System.out.println("email: "+email);
        System.out.println("admin: "+admin);
    }
}

