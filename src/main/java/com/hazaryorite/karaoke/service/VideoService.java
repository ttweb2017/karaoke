package com.hazaryorite.karaoke.service;

import com.hazaryorite.karaoke.domain.Singer;
import com.hazaryorite.karaoke.domain.Video;
import com.hazaryorite.karaoke.repos.VideoRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

@Service
public class VideoService {
    public final static String VIDEO_PATH = "videos";

    private final VideoRepo videoRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    public VideoService(VideoRepo videoRepo) {
        this.videoRepo = videoRepo;
    }

    public List<Video> findAll(){
        return videoRepo.findAll();
    }

    public List<Video> findAllByActive(boolean active){
        return videoRepo.findAllByActive(active);
    }

    public void save(Video video){
        videoRepo.save(video);
    }

    public List<Video> findAllBySinger(Singer singer){
        return videoRepo.findAllBySinger(singer);
    }

    public void delete(Video video) {
        videoRepo.delete(video);
    }

    public void saveFile(Video video, List<MultipartFile> videoFile) throws IOException {

        if (videoFile != null && !videoFile.isEmpty()) {
            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            File catalogDir = new File(uploadDir + "/" + VideoService.VIDEO_PATH);

            if (!catalogDir.exists()) {
                catalogDir.mkdir();
            }

            for (MultipartFile file : videoFile) {

                if (file.isEmpty()) {
                    continue; //next pls
                }

                String uuidFile = UUID.randomUUID().toString();
                String resultFilename = uuidFile + "." + file.getOriginalFilename();

                file.transferTo(new File(uploadPath + "/" + VideoService.VIDEO_PATH + "/" + resultFilename));

                if(Objects.requireNonNull(file.getOriginalFilename()).endsWith(".png")
                        || Objects.requireNonNull(file.getOriginalFilename()).endsWith(".jpeg")
                        || Objects.requireNonNull(file.getOriginalFilename()).endsWith(".JPEG")
                        || Objects.requireNonNull(file.getOriginalFilename()).endsWith(".jpg")){
                    video.setImage(resultFilename);
                }else{
                    video.setVideo(resultFilename);
                }
            }
        }

    }
}
