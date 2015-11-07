package com.daggerok.blog;

import com.daggerok.blog.domain.Post;
import com.daggerok.blog.domain.PostRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.test.context.ActiveProfiles;

import java.util.Arrays;

@Configuration
@ActiveProfiles("Test")
public class TestData {
    @Bean
    public CommandLineRunner run(PostRepository repository) {
        return args -> Arrays.asList("one,two,three,four".split(","))
                .forEach(word -> repository.save(Post.create(word, word, word)));
    }
}
