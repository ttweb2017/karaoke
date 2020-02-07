package com.hazaryorite.karaoke.domain;

import com.fasterxml.jackson.annotation.JsonView;
import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
public class Video {
    @JsonView(Views.FullProfile.class)
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @JsonView(Views.FullProfile.class)
    @NotBlank(message = "Name field can't be empty!")
    @Length(max = 255, message = "Name can't be more than 255 chars")
    private String name;

    @JsonView(Views.FullProfile.class)
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "singer_id")
    private Singer singer;

    @JsonView(Views.FullProfile.class)
    @Length(max = 255, message = "Video can't be more than 255 chars")
    private String video;

    @JsonView(Views.FullProfile.class)
    @Length(max = 255, message = "Image can't be more than 255 chars")
    private String image;

    @JsonView(Views.FullProfile.class)
    private int watchedCounter = 0;

    @JsonView(Views.FullProfile.class)
    private LocalDateTime addedDateTime;

    private boolean active;

    public String getFormattedDate(){

        DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("dd MMMM yyyy");

        return addedDateTime.format(dateFormat);
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Singer getSinger() {
        return singer;
    }

    public void setSinger(Singer singer) {
        this.singer = singer;
    }

    public String getVideo() {
        return video;
    }

    public void setVideo(String video) {
        this.video = video;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getWatchedCounter() {
        return watchedCounter;
    }

    public void setWatchedCounter(int watchedCounter) {
        this.watchedCounter = watchedCounter;
    }

    public LocalDateTime getAddedDateTime() {
        return addedDateTime;
    }

    public void setAddedDateTime(LocalDateTime addedDateTime) {
        this.addedDateTime = addedDateTime;
    }

    @Override
    public String toString() {
        return "Video{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", singer=" + singer +
                ", video='" + video + '\'' +
                ", image='" + image + '\'' +
                ", watchedCounter=" + watchedCounter +
                ", addedDateTime=" + addedDateTime +
                ", active=" + active +
                '}';
    }
}
