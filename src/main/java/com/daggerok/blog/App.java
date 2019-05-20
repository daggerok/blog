package com.daggerok.blog;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class App {
    public static void main(String[] args) {
        SpringApplication.run(App.class, args)
                // curl -XPOST localhost:8081/admin/shutdown
                .registerShutdownHook();
    }
}
