package com.hazaryorite.karaoke.repos;

import com.hazaryorite.karaoke.domain.Catalog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CatalogRepo extends JpaRepository<Catalog, Long> {
    List<Catalog> findAllByActive(boolean active);
}
