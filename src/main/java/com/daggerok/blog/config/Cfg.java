package com.daggerok.blog.config;

import com.daggerok.blog.Application;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@ComponentScan(basePackageClasses = {Application.class})
public class Cfg {}
