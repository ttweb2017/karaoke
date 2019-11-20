package com.hazaryorite.karaoke.controller;

import com.fasterxml.jackson.annotation.JsonView;
import com.hazaryorite.karaoke.domain.Singer;
import com.hazaryorite.karaoke.domain.Views;
import com.hazaryorite.karaoke.service.SingerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/singers")
public class SingerController {
    private final SingerService singerService;

    @Autowired
    public SingerController(SingerService singerService) {
        this.singerService = singerService;
    }

    @JsonView(Views.FullProfile.class)
    @GetMapping
    public List<Singer> singers(){
        return singerService.findAllByActive(true);
    }
}
