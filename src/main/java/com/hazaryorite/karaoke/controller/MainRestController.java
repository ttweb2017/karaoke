package com.hazaryorite.karaoke.controller;

import com.hazaryorite.karaoke.domain.Catalog;
import com.hazaryorite.karaoke.service.CatalogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/catalogs")
public class MainRestController {
    private final CatalogService catalogService;

    @Autowired
    public MainRestController(CatalogService catalogService) {
        this.catalogService = catalogService;
    }

    @GetMapping
    public List<Catalog> catalogs(){
        return catalogService.findAllByActive(true);
    }
}
