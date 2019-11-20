package com.hazaryorite.karaoke.controller;

import com.hazaryorite.karaoke.domain.Singer;
import com.hazaryorite.karaoke.domain.Video;
import com.hazaryorite.karaoke.service.SingerService;
import com.hazaryorite.karaoke.service.VideoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Arrays;

@Controller
@RequestMapping("/admin")
public class AdminVideoController {
    private final VideoService videoService;

    private final SingerService singerService;

    @Autowired
    public AdminVideoController(VideoService videoService, SingerService singerService) {
        this.videoService = videoService;
        this.singerService = singerService;
    }

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MODERATOR')")
    @GetMapping("/videos")
    public String videos(Model model){

        model.addAttribute("videos", videoService.findAll());
        model.addAttribute("singers", singerService.findAllByActive(true));

        return "admin/videoList";
    }

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MODERATOR')")
    @GetMapping("/edit-video/{video}")
    public String editCatalog(@PathVariable Video video, Model model){
        model.addAttribute("video", video);
        model.addAttribute("singers", singerService.findAllByActive(true));

        return "admin/videoEdit";
    }

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MODERATOR')")
    @PostMapping("/edit-video")
    public String editVideo(
            @RequestParam("videoId") Video video,
            @RequestParam("singer") Singer singer,
            @RequestParam String name,
            @RequestParam boolean active,
            @RequestParam("files") MultipartFile[] uploadFiles){

        if(!video.getName().equals(name) && !name.isEmpty()){
            video.setName(name);
        }

        video.setSinger(singer);
        video.setActive(active);

        try {
            videoService.saveFile(video, Arrays.asList(uploadFiles));
            videoService.save(video);

        } catch (IOException e) {
            e.printStackTrace();
        }

        return "redirect:/admin/videos";
    }
}
