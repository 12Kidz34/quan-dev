package com.poly.service;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    // Lấy đối tượng Authentication hiện tại
    public Authentication getAuthentication() {
        return SecurityContextHolder.getContext().getAuthentication();
    }

    // Lấy username người đang đăng nhập
    public String getUsername() {
        Authentication auth = getAuthentication();
        if (auth != null && auth.getPrincipal() instanceof UserDetails user) {
            return user.getUsername();
        }
        return "Anonymous";
    }

    // Kiểm tra xem có đang đăng nhập không
    public boolean isAuthenticated() {
        Authentication auth = getAuthentication();
        return auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getName());
    }
}
