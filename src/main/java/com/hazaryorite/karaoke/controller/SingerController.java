package com.hazaryorite.karaoke.controller;

import com.fasterxml.jackson.annotation.JsonView;
import com.hazaryorite.karaoke.domain.Singer;
import com.hazaryorite.karaoke.domain.Video;
import com.hazaryorite.karaoke.domain.Views;
import com.hazaryorite.karaoke.service.SingerService;
import com.hazaryorite.karaoke.service.VideoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/singers")
public class SingerController {
    private final SingerService singerService;
    private final VideoService videoService;

    @Autowired
    public SingerController(SingerService singerService, VideoService videoService) {
        this.singerService = singerService;
        this.videoService = videoService;
    }

    @JsonView(Views.FullProfile.class)
    @GetMapping
    public List<Singer> singers(){
        return singerService.findAllByActive(true);
    }

    @JsonView(Views.FullProfile.class)
    @GetMapping("/{singer}")
    public List<Video> songsOfCurrentSinger(@PathVariable Singer singer){
        return videoService.findAllBySingerAndVideoIsNotNull(singer);
    }
}
