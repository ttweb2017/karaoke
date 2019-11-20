package com.hazaryorite.karaoke.service;

import com.hazaryorite.karaoke.domain.Catalog;
import com.hazaryorite.karaoke.repos.CatalogRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Service
public class CatalogService {
    public final static String CATALOG_PATH = "catalog";

    private final CatalogRepo catalogRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    public CatalogService(CatalogRepo catalogRepo) {
        this.catalogRepo = catalogRepo;
    }

    public List<Catalog> findAll(){
        return catalogRepo.findAll();
    }

    public List<Catalog> findAllByActive(boolean active){
        return catalogRepo.findAllByActive(active);
    }

    public Catalog save(Catalog catalog){
        catalogRepo.save(catalog);

        return catalog;
    }

    public void saveFile(@Valid Catalog catalog, @RequestParam("file") MultipartFile file) throws IOException {
        if (file != null && !file.getOriginalFilename().isEmpty()) {
            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            File catalogDir = new File(uploadDir + "/" + CatalogService.CATALOG_PATH);

            if(!catalogDir.exists()){
                catalogDir.mkdir();
            }

            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "." + file.getOriginalFilename();

            file.transferTo(new File(uploadPath + "/" + CatalogService.CATALOG_PATH + "/" + resultFilename));

            catalog.setImg(resultFilename);
        }
    }
}
