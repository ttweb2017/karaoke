package com.hazaryorite.karaoke.controller;

import com.fasterxml.jackson.annotation.JsonView;
import com.hazaryorite.karaoke.domain.User;
import com.hazaryorite.karaoke.domain.Views;
import com.hazaryorite.karaoke.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/admin")
public class AdminUserRestController {
    private final UserService userService;

    @Autowired
    public AdminUserRestController(UserService userService) {
        this.userService = userService;
    }

    @JsonView(Views.FullProfile.class)
    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/add-user")
    public User add(@RequestBody User user){

        /*AjaxResponseBody result = new AjaxResponseBody();

        //If error, just return a 400 bad request, along with the error message
        if (errors.hasErrors()) {

            result.setMsg(errors.getAllErrors()
                    .stream().map(x -> x.getDefaultMessage())
                    .collect(Collectors.joining(",")));

            return ResponseEntity.badRequest().body(result);

        }*/

        return userService.save(user);
    }

    @JsonView(Views.IdName.class)
    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/check-username/{username}")
    public User checkUsername(@PathVariable String username){

        User user = userService.findByUsername(username);

        if(user == null){
            return new User();
        }

        return user;
    }
}
