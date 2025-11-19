package com.poly.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "UserRoles")
public class UserRole {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "Username")
    private User user;

    @ManyToOne
    @JoinColumn(name = "RoleId")
    private Role role;

    // ===== Constructors =====
    public UserRole() {}

    public UserRole(User user, Role role) {
        this.user = user;
        this.role = role;
    }

    // ===== Getters & Setters =====
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }
}
