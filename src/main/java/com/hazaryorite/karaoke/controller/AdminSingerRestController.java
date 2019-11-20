package com.hazaryorite.karaoke.controller;

import com.hazaryorite.karaoke.domain.Singer;
import com.hazaryorite.karaoke.service.SingerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.IOException;

@RestController
@RequestMapping("/admin")
public class AdminSingerRestController {
    private final SingerService singerService;

    @Autowired
    public AdminSingerRestController(SingerService singerService) {
        this.singerService = singerService;
    }

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MODERATOR')")
    @PostMapping("/add-singer")
    public Singer addSinger(
            @Valid @ModelAttribute Singer singer,
            @RequestParam("file") MultipartFile uploadFile) {

        try {
            singerService.saveFile(singer, uploadFile);
            singerService.save(singer);

            return singer;
        } catch (IOException e) {
            e.printStackTrace();

            return new Singer();
        }
    }
}
