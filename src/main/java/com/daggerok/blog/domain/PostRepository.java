package com.daggerok.blog.domain;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.cache.annotation.*;
import org.springframework.transaction.annotation.Transactional;

import static  com.daggerok.blog.config.CacheConfig.*;

@Transactional
@RepositoryRestResource
@CacheConfig(cacheNames = post)
public interface PostRepository extends JpaRepository<Post, Long> {}
