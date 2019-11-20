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

    @Value("${upload.path}")
    private String uploadPath;

    private final Long CHUNK_SIZE = 100000L;

    @Autowired
    public VideoController(VideoService videoService) {
        this.videoService = videoService;
    }

    @JsonView(Views.FullProfile.class)
    @GetMapping("/videos")
    public List<Video> videos(){
        return videoService.findAllByActive(true);
    }

    @GetMapping("/full-video/{name}")
    public ResponseEntity<UrlResource> getFullVideo(@PathVariable String name) throws MalformedURLException {

        String videoPath = uploadPath + "/" + VideoService.VIDEO_PATH + "/";
        File videoFilePath = new File(videoPath + name);

        UrlResource video = new UrlResource("file:///" + videoFilePath.getPath());

        return ResponseEntity.status(PARTIAL_CONTENT)
                .contentType(MediaTypeFactory.getMediaType(video)
                        .orElse(MediaType.APPLICATION_OCTET_STREAM))
                .body(video);
    }

    @GetMapping("/video/{name}")
    public ResponseEntity<ResourceRegion> getVideo(
            @PathVariable String name,
            @RequestHeader HttpHeaders headers) throws IOException {

        String videoPath = uploadPath + "/" + VideoService.VIDEO_PATH + "/";
        UrlResource video = new UrlResource("file:///" + videoPath + name);
        ResourceRegion region = resourceRegion(video, headers);

        return ResponseEntity.status(PARTIAL_CONTENT)
                .contentType(MediaTypeFactory.getMediaType(video).orElse(MediaType.APPLICATION_OCTET_STREAM))
                .body(region);
    }

    private ResourceRegion resourceRegion(UrlResource video, HttpHeaders headers) throws IOException {
        Long contentLength = video.contentLength();
        HttpRange range = headers.getRange()
                .stream()
                .findFirst()
                .orElse(null);

        if (range != null) {
            long start = range.getRangeStart(contentLength);
            Long end = range.getRangeEnd(contentLength);
            long rangeLength = min(CHUNK_SIZE, end - start + 1);
            return new ResourceRegion(video, start, rangeLength);
        } else {
            long rangeLength = min(CHUNK_SIZE, contentLength);
            return new ResourceRegion(video, 0, rangeLength);
        }
    }
}
