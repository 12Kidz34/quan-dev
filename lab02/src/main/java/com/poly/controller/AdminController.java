package com.poly.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin/users")
public class AdminController {
    @Autowired
    private JdbcTemplate jdbc;


    @Autowired
    JdbcUserDetailsManager userManager;

    @GetMapping
    public String listUsers(Model model) {
        String sql = "SELECT u.username, GROUP_CONCAT(a.authority SEPARATOR ', ') AS roles " +
                "FROM users u LEFT JOIN authorities a ON u.username = a.username " +
                "GROUP BY u.username";

        List<UserSummary> users = jdbc.query(sql, (rs, rowNum) -> {
            UserSummary user = new UserSummary();
            user.setUsername(rs.getString("username"));
            user.setRoles(rs.getString("roles"));
            return user;
        });

        model.addAttribute("users", users);
        return "user-list";
    }


    // 🆕 Form thêm mới
    @GetMapping("/new")
    public String createForm(Model model) {
        model.addAttribute("user", new UserForm());
        return "user-form";
    }

    // 💾 Lưu người dùng mới
    @PostMapping("/save")
    public String saveUser(@ModelAttribute("user") UserForm form) {
        UserDetails user = User.withUsername(form.getUsername())
                .password("{noop}" + form.getPassword())
                .roles(form.getRole())
                .build();
        userManager.createUser(user);
        return "redirect:/admin/users";
    }

    // ❌ Xóa người dùng
    @GetMapping("/delete/{username}")
    public String deleteUser(@PathVariable String username) {
        userManager.deleteUser(username);
        return "redirect:/admin/users";
    }

    // 📝 Cập nhật (gồm disable/enable)
    @GetMapping("/toggle/{username}")
    public String toggleUser(@PathVariable String username) {
        var user = userManager.loadUserByUsername(username);
        boolean enabled = !user.isEnabled();
        userManager.updateUser(User.withUserDetails(user).disabled(!enabled).build());
        return "redirect:/admin/users";
    }
}
