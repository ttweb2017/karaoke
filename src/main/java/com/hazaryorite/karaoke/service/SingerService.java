package com.hazaryorite.karaoke.service;

import com.hazaryorite.karaoke.domain.Singer;
import com.hazaryorite.karaoke.repos.SingerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Service
public class SingerService {
    public final static String SINGER_PATH = "singer";

    @Value("${upload.path}")
    private String uploadPath;

    private final SingerRepo singerRepo;

    @Autowired
    public SingerService(SingerRepo singerRepo) {
        this.singerRepo = singerRepo;
    }

    public List<Singer> findAll(){
        return singerRepo.findAll();
    }

    public List<Singer> findAllByActive(boolean active){
        return singerRepo.findAllByActive(active);
    }

    public List<Singer> findAllByActiveOrderByFirstNameAsc(boolean active){
        return singerRepo.findAllByActiveOrderByFirstNameAsc(active);
    }

    public Singer save(Singer singer) {
        singerRepo.save(singer);

        return singer;
    }

    public void delete(Singer singer){
        singerRepo.delete(singer);
    }

    public void saveFile(Singer singer, MultipartFile uploadFile) throws IOException {
        if (uploadFile != null && !uploadFile.getOriginalFilename().isEmpty()) {
            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            File singerDir = new File(uploadDir + "/" + SINGER_PATH);

            if(!singerDir.exists()){
                singerDir.mkdir();
            }

            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "." + uploadFile.getOriginalFilename();

            uploadFile.transferTo(new File(uploadPath + "/" + SINGER_PATH + "/" + resultFilename));

            singer.setAvatar(resultFilename);
        }
    }
}
