package com.hazaryorite.karaoke.controller;

import com.hazaryorite.karaoke.domain.Video;
import com.hazaryorite.karaoke.service.VideoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Arrays;

@RestController
@RequestMapping("/admin")
public class AdminVideoRestController {
    private final VideoService videoService;

    @Autowired
    public AdminVideoRestController(VideoService videoService) {
        this.videoService = videoService;
    }

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MODERATOR')")
    @PostMapping("/add-video")
    public Video addVideo(
            @ModelAttribute Video video,
            @RequestParam("files") MultipartFile[] uploadFile) {

        try {
            videoService.saveFile(video, Arrays.asList(uploadFile));
            videoService.save(video);

            return video;
        } catch (IOException e) {
            e.printStackTrace();

            return new Video();
        }
    }
}
