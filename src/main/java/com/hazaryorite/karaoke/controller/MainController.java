package com.hazaryorite.karaoke.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

    @GetMapping("/")
    public String main() {

        return "front/main";
    }

    @GetMapping("/error")
    public String error(){
        return "error";
    }
}
