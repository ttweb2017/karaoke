package com.hazaryorite.karaoke.controller;

import com.hazaryorite.karaoke.domain.Catalog;
import com.hazaryorite.karaoke.service.CatalogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Controller
@RequestMapping("/admin")
public class AdminCatalogController {
    private final CatalogService catalogService;

    @Autowired
    public AdminCatalogController(CatalogService catalogService) {
        this.catalogService = catalogService;
    }

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MODERATOR')")
    @GetMapping("/catalogs")
    public String catalogs(Model model){
        model.addAttribute("catalogs", catalogService.findAll());
        return "admin/catalogList";
    }

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MODERATOR')")
    @GetMapping("/edit-catalog/{catalog}")
    public String editCatalog(@PathVariable Catalog catalog, Model model){
        model.addAttribute("catalog", catalog);

        return "admin/catalogEdit";
    }

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MODERATOR')")
    @PostMapping("/edit-catalog")
    public String editCatalog(
            @RequestParam("catalogId") Catalog catalog,
            @RequestParam String name,
            @RequestParam String description,
            @RequestParam boolean active,
            @RequestParam("file") MultipartFile uploadFile){

        if(!catalog.getName().equals(name) && !name.isEmpty()){
            catalog.setName(name);
        }

        if(!catalog.getDescription().equals(description) && !description.isEmpty()){
            catalog.setDescription(description);
        }

        catalog.setActive(active);

        try {
            catalogService.saveFile(catalog, uploadFile);
            catalogService.save(catalog);

        } catch (IOException e) {
            e.printStackTrace();
        }

        return "redirect:/admin/catalogs";
    }
}
