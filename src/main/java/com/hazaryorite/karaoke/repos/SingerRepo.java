package com.hazaryorite.karaoke.repos;

import com.hazaryorite.karaoke.domain.Singer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SingerRepo extends JpaRepository<Singer, Long> {
    List<Singer> findAllByActive(boolean active);
}
