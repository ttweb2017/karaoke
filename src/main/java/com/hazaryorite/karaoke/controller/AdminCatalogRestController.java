package com.hazaryorite.karaoke.controller;

import com.hazaryorite.karaoke.domain.Catalog;
import com.hazaryorite.karaoke.service.CatalogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.IOException;

@RestController
@RequestMapping("/admin")
public class AdminCatalogRestController {
    private final CatalogService catalogService;

    @Autowired
    public AdminCatalogRestController(CatalogService catalogService) {
        this.catalogService = catalogService;
    }

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MODERATOR')")
    @PostMapping("/add-catalog")
    public Catalog addCatalog(
            @Valid @ModelAttribute Catalog catalog,
            @RequestParam("file") MultipartFile uploadFile) {

        System.out.println(catalog.isActive());
        try {
            catalogService.saveFile(catalog, uploadFile);
            catalogService.save(catalog);

            return catalog;
        } catch (IOException e) {
            e.printStackTrace();

            return new Catalog();
        }
    }
}
