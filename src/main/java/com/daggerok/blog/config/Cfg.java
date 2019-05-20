package com.daggerok.blog.config;

import com.daggerok.blog.App;
import com.daggerok.blog.domain.Comment;
import com.daggerok.blog.domain.Post;
import com.daggerok.blog.domain.PostsRepository;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;
import org.springframework.hateoas.config.EnableEntityLinks;

import java.util.Arrays;
import java.util.HashSet;
import java.util.logging.Logger;
import java.util.stream.IntStream;

@Configuration
@EnableEntityLinks
@EnableMongoRepositories(basePackageClasses = App.class)
@EnableAutoConfiguration(exclude = {org.springframework.boot.autoconfigure.security.SecurityAutoConfiguration.class})
@ComponentScan(basePackageClasses = App.class, basePackages = {"org.springframework.data.jpa.convert.threeten"})
// JSR310 + Spring Data
public class Cfg {
    private static final Logger logger = Logger.getLogger(Cfg.class.getName());

    @Bean
    @Profile("dev")
    public CommandLineRunner runner(PostsRepository repository) {
        return args -> IntStream.rangeClosed(1, 5).forEach(i -> {
            String author = RandomStringUtils.randomAlphabetic(5) + " " + RandomStringUtils.randomAlphabetic(7),
                    tittle = RandomStringUtils.randomAlphabetic(20),
                    body = RandomStringUtils.randomAlphabetic(2000),
                    comment = RandomStringUtils.randomAlphabetic(30);
            Post post = Post.of(author, tittle, body);

            post.setComments(new HashSet<>(Arrays.asList(
                    Comment.of("anonymous", "cool"),
                    (i % 2 == 0) ? Comment.of(author, comment) : Comment.of("anonymous", "watta shit!")
            )));
            logger.info(String.format("saving post: %s", post));
            repository.save(post);
        });
    }
}
