package com.hazaryorite.karaoke.controller;

import com.hazaryorite.karaoke.domain.Role;
import com.hazaryorite.karaoke.domain.User;
import com.hazaryorite.karaoke.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminUserController {
    private final UserService userService;

    private final PasswordEncoder passwordEncoder;

    @Autowired
    public AdminUserController(UserService userService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/users")
    public String users(Model model){

        model.addAttribute("users", userService.findAll());
        model.addAttribute("roles", Role.values());

        return "admin/usersList";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/edit-user/{user}")
    public String edit(@PathVariable User user, Model model){

        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());

        return "admin/userEdit";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/edit-user")
    public String editUser(
            @RequestParam("userId") User user,
            @RequestParam String firstName,
            @RequestParam String lastName,
            @RequestParam String username,
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam String confirmPassword,
            @RequestParam boolean status,
            @RequestParam Map<String, String> form){

        if(!user.getFirstName().equals(firstName) && !firstName.isEmpty()){
            user.setFirstName(firstName);
        }

        if(!user.getLastName().equals(lastName) && !lastName.isEmpty()){
            user.setLastName(lastName);
        }

        if(!user.getUsername().equals(username) && !username.isEmpty()){
            user.setUsername(username);
        }

        if(!user.getEmail().equals(email) && !email.isEmpty()){
            user.setEmail(email);
        }

        if(!password.isEmpty() && password.equals(confirmPassword)){
            user.setPassword(passwordEncoder.encode(password));
        }

        user.setActive(status);

        userService.updateUser(user, form);

        return "redirect:/admin/users";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/delete-user/{user}")
    public String delete(@PathVariable User user){

        userService.delete(user);

        return "redirect:/admin/users";
    }
}
