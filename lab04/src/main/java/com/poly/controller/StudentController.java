package com.poly.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class StudentController {

    @GetMapping("/student")
    public String page() {
        return "student-crud";
    }

    @GetMapping("/rest-client")
    public String rest() {
        return "rest-client";
    }
}

