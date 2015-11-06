package com.daggerok.blog.config;

import com.daggerok.blog.Application;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration // JSR310 + Spring Data:
@ComponentScan(basePackageClasses = {Application.class},
    basePackages = {"org.springframework.data.jpa.convert.threeten"})
public class Cfg {}
