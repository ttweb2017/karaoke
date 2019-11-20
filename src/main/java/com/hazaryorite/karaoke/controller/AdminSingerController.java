package com.hazaryorite.karaoke.controller;

import com.hazaryorite.karaoke.domain.Singer;
import com.hazaryorite.karaoke.service.SingerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Controller
@RequestMapping("/admin")
public class AdminSingerController {
    private final SingerService singerService;

    @Autowired
    public AdminSingerController(SingerService singerService) {
        this.singerService = singerService;
    }

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MODERATOR')")
    @GetMapping("/singers")
    public String singer(Model model){
        model.addAttribute("singers", singerService.findAll());

        return "admin/singerList";
    }

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MODERATOR')")
    @GetMapping("/edit-singer/{singer}")
    public String editSinger(@PathVariable Singer singer, Model model){
        model.addAttribute("singer", singer);

        return "admin/singerEdit";
    }

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MODERATOR')")
    @PostMapping("/edit-singer")
    public String editSinger(
            @RequestParam("singerId") Singer singer,
            @RequestParam String firstName,
            @RequestParam String lastName,
            @RequestParam boolean active,
            @RequestParam("file") MultipartFile uploadFile){

        if(!singer.getFirstName().equals(firstName) && !firstName.isEmpty()){
            singer.setFirstName(firstName);
        }

        if(!singer.getLastName().equals(lastName) && !lastName.isEmpty()){
            singer.setLastName(lastName);
        }

        singer.setActive(active);

        try {
            singerService.saveFile(singer, uploadFile);
            singerService.save(singer);

        } catch (IOException e) {
            e.printStackTrace();
        }

        return "redirect:/admin/singers";
    }
}
