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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminSingerController {
    private final SingerService singerService;
    private final VideoService videoService;

    @Autowired
    public AdminSingerController(SingerService singerService, VideoService videoService) {
        this.singerService = singerService;
        this.videoService = videoService;
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

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/delete-singer/{singer}")
    public String deleteSinger(@PathVariable Singer singer, RedirectAttributes redirectAttributes){
        if(singer == null){
            redirectAttributes.addFlashAttribute("type", "error");
            redirectAttributes.addFlashAttribute("message", "There is not such a Singer, sorry!");

            return "redirect:/admin/singers";
        }

        List<Video> videoList = videoService.findAllBySinger(singer);
        if(videoList.size() != 0){
            StringBuilder videosBuilder = new StringBuilder();

            Iterator<Video> iterator = videoList.iterator();
            while (iterator.hasNext()) {
                videosBuilder.append(iterator.next().getName());
                //Do stuff
                if (iterator.hasNext()) {
                    videosBuilder.append(", ");
                }
            }

            redirectAttributes.addFlashAttribute("type", "danger");
            redirectAttributes.addFlashAttribute(
                    "message",
                    "This <b>" + videosBuilder.toString() + "</b> songs are belongs to <i>\"" + singer.getFirstName() +
                            " " + singer.getLastName() + "\"</i>. Delete them first!"
            );

            return "redirect:/admin/singers";
        }

        singerService.delete(singer);

        redirectAttributes.addFlashAttribute("type", "success");
        redirectAttributes.addFlashAttribute("message", "Singer has been removed successfully!");

        return "redirect:/admin/singers";
    }
}
