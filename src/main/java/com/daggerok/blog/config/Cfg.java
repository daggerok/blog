package com.daggerok.blog.config;

import com.daggerok.blog.Application;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@ComponentScan(basePackageClasses = {Application.class},
    basePackages = {"org.springframework.data.jpa.convert.threeten"}) // JSR310 + Spring Data
public class Cfg {}
