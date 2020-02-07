package com.hazaryorite.karaoke.controller;

import com.fasterxml.jackson.annotation.JsonView;
import com.hazaryorite.karaoke.domain.Video;
import com.hazaryorite.karaoke.domain.Views;
import com.hazaryorite.karaoke.service.VideoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.UrlResource;
import org.springframework.core.io.support.ResourceRegion;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.util.List;

import static java.lang.Math.min;
import static org.springframework.http.HttpStatus.PARTIAL_CONTENT;

@RestController
@RequestMapping("/api")
public class VideoController {
    private final VideoService videoService;

    @Autowired
    public VideoController(VideoService videoService) {
        this.videoService = videoService;
    }

    @JsonView(Views.FullProfile.class)
    @GetMapping("/videos")
    public List<Video> videos(){
        return videoService.findAllByActiveAndVideoIsNotNull(true);
    }

    @JsonView(Views.FullProfile.class)
    @GetMapping("/top5-videos")
    public List<Video> top5Videos(){
        return videoService.findTop5ByActiveAndVideoIsNotNullOrderByWatchedCounterDesc(true);
    }

    @JsonView(Views.FullProfile.class)
    @GetMapping("/top10-videos")
    public List<Video> top10Videos(){
        return videoService.findTop10ByActiveAndVideoIsNotNullOrderByWatchedCounterDesc(true);
    }

    @JsonView(Views.FullProfile.class)
    @GetMapping("/top20-videos")
    public List<Video> top20Videos(){
        return videoService.findTop20ByActiveAndVideoIsNotNullOrderByWatchedCounterDesc(true);
    }

    @GetMapping("/update-watch-count/{video}")
    public void updateWatchCount(@PathVariable Video video){
        if(video != null){
            video.setWatchedCounter(video.getWatchedCounter() + 1);
            videoService.save(video);
        }
    }
}
