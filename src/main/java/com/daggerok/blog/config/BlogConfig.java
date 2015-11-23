package com.daggerok.blog.config;

import com.daggerok.blog.BlogApp;
import com.daggerok.blog.domain.Comment;
import com.daggerok.blog.domain.Post;
import com.daggerok.blog.domain.PostsRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.hateoas.config.EnableEntityLinks;

import java.util.Arrays;
import java.util.HashSet;

@Configuration
@EnableEntityLinks
@EnableAutoConfiguration(exclude = {org.springframework.boot.autoconfigure.security.SecurityAutoConfiguration.class})
@ComponentScan(basePackageClasses = {BlogApp.class}, basePackages = {"org.springframework.data.jpa.convert.threeten"}) // JSR310 + Spring Data
public class BlogConfig {
        @Bean
        public CommandLineRunner runner(PostsRepository repository) {
                return args -> {
                        Arrays.asList(1,2).forEach(i -> {
                                Post post = Post.of("test author "+i, "test post "+i, "test content "+i);
                                post.setComments(new HashSet<>(Arrays.asList(
                                        Comment.of("anonymous "+i,"cool"),
                                        Comment.of("anonymous "+i+1, "shit")
                                )));
                                repository.save(post);
                        });
                };
        }
}
