package com.daggerok.blog.config;

import com.daggerok.blog.Blog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ExitCodeGenerator;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.batch.JobExecutionExitCodeGenerator;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@ComponentScan(basePackageClasses = {Blog.class},
        basePackages = {"org.springframework.data.jpa.convert.threeten"}) // JSR310 + Spring Data
public class BlogAppConfig {}
