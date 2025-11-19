package com.poly.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class PreAuthController {

    @GetMapping("/pre/url1")
    @ResponseBody
    @PreAuthorize("isAuthenticated()")
    public String url1() {
        return "URL1: Yêu cầu đăng nhập!";
    }

    @GetMapping("/pre/url2")
    @ResponseBody
    @PreAuthorize("hasRole('USER')")
    public String url2() {
        return "URL2: Chỉ USER truy cập được!";
    }

    @GetMapping("/pre/url3")
    @ResponseBody
    @PreAuthorize("hasRole('ADMIN')")
    public String url3() {
        return "URL3: Chỉ ADMIN truy cập được!";
    }

    @GetMapping("/pre/url4")
    @ResponseBody
    @PreAuthorize("hasAnyRole('USER','ADMIN')")
    public String url4() {
        return "URL4: USER hoặc ADMIN đều được vào!";
    }
}
