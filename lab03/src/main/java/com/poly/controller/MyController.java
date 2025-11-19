package com.poly.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MyController {

    @RequestMapping({"/", "/poly/home"})
    public String home(Model model) {
        model.addAttribute("message", "/poly/home => home()");
        return "page";
    }

    @PreAuthorize("hasRole('OAUTH')")
    @RequestMapping("/poly/url0")
    public String url0(Model model) {
        model.addAttribute("message", "/poly/url0 => method0()");
        return "page";
    }


    @PreAuthorize("isAuthenticated()")
    @RequestMapping("/poly/url1")
    public String url1(Model model) {
        model.addAttribute("message", "/poly/url1 => method1()");
        return "page";
    }

    // URL2 → chỉ USER
    @PreAuthorize("hasRole('USER')")
    @RequestMapping("/poly/url2")
    public String url2(Model model) {
        model.addAttribute("message", "/poly/url2 => method2()");
        return "page";
    }

    // URL3 → chỉ ADMIN
    @PreAuthorize("hasRole('ADMIN')")
    @RequestMapping("/poly/url3")
    public String url3(Model model) {
        model.addAttribute("message", "/poly/url3 => method3()");
        return "page";
    }

    // URL4 → USER hoặc ADMIN
    @PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    @RequestMapping("/poly/url4")
    public String url4(Model model) {
        model.addAttribute("message", "/poly/url4 => method4()");
        return "page";
    }

    // ==================================
    // 🔥 Khi bị từ chối truy cập
    // ==================================
    @RequestMapping("/access-denied")
    public String denied(Model model) {
        model.addAttribute("message", "🚫 Bạn không có quyền truy cập trang này!");
        return "access-denied";
    }
}
