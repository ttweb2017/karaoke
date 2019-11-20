package com.hazaryorite.karaoke.service;

import com.hazaryorite.karaoke.domain.Role;
import com.hazaryorite.karaoke.domain.User;
import com.hazaryorite.karaoke.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {
    private final UserRepo userRepo;

    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserService(UserRepo userRepo, PasswordEncoder passwordEncoder) {
        this.userRepo = userRepo;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepo.findByUsername(username);

        if (user == null) {
            throw new UsernameNotFoundException("User not found");
        }

        return user;
    }

    public User findByUsername(String username){
        return userRepo.findByUsername(username);
    }

    public List<User> findAll(){
        return userRepo.findAll();
    }

    public User save(User user){
        if(user.getFirstName().isEmpty()){
            user.setFirstName("User");
        }

        if(user.getLastName().isEmpty()){
            user.setLastName("User");
        }

        if(!user.getUsername().isEmpty()
                && !user.getEmail().isEmpty()
                && !user.getPassword().isEmpty()
                && !user.getConfirmPassword().isEmpty()
                && user.getPassword().equals(user.getConfirmPassword())){

            user.setActive(true);
            user.setPassword(passwordEncoder.encode(user.getPassword()));
            user.setRoles(Collections.singleton(Role.USER));

            userRepo.save(user);
        }

        return user;
    }

    public void delete(User user){
        userRepo.delete(user);
    }

    public void updateUser(User user, Map<String, String> form) {
        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());

        user.getRoles().clear();

        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }

        userRepo.save(user);
    }
}
