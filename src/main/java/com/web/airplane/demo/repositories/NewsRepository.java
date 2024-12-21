package com.web.airplane.demo.repositories;


import com.web.airplane.demo.models.News;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface NewsRepository extends JpaRepository<News, Long> {
    @Query(value = "SELECT MAX(n.news_index) FROM News n", nativeQuery = true)
    Long findMaxIndex();

    News findByNewsIndex(Long id);

    News findByTitle(String title);
}
