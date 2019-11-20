package com.hazaryorite.karaoke.domain;

import com.fasterxml.jackson.annotation.JsonView;
import org.hibernate.validator.constraints.Length;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.NotBlank;

@Entity
public class Singer {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @JsonView(Views.FullProfile.class)
    private Long id;

    @JsonView(Views.FullProfile.class)
    @NotBlank(message = "First Name field can't be empty!")
    @Length(max = 255, message = "First Name can't be more than 255 chars")
    private String firstName;

    @JsonView(Views.FullProfile.class)
    @NotBlank(message = "Last Name field can't be empty!")
    @Length(max = 255, message = "Last Name can't be more than 255 chars")
    private String lastName;

    @JsonView(Views.FullProfile.class)
    private String avatar = "default.svg";

    private boolean active;

    public String getFullName(){
        return firstName + " " + lastName;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
}
