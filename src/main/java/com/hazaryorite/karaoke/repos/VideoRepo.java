package com.hazaryorite.karaoke.repos;

import com.hazaryorite.karaoke.domain.Singer;
import com.hazaryorite.karaoke.domain.Video;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface VideoRepo extends JpaRepository<Video, Long> {
    List<Video> findAllByActive(boolean active);

    List<Video> findAllByActiveAndVideoIsNotNull(boolean active);

    List<Video> findAllBySinger(Singer singer);

    List<Video> findAllBySingerAndVideoIsNotNull(Singer singer);

    List<Video> findTop5ByActiveAndVideoIsNotNullOrderByWatchedCounterDesc(boolean active);

    List<Video> findTop10ByActiveAndVideoIsNotNullOrderByWatchedCounterDesc(boolean active);

    List<Video> findTop20ByActiveAndVideoIsNotNullOrderByWatchedCounterDesc(boolean active);
}
