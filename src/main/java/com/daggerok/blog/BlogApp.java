package com.daggerok.blog;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class BlogApp {
    public static void main(String[] args) {
        SpringApplication.run(BlogApp.class, args)
                .registerShutdownHook(); // curl -XPOST localhost:8081/admin/shutdown
    }
}
