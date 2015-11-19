package com.daggerok.blog.domain;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import java.util.Collection;

@RepositoryRestResource
public interface PostsRepository extends MongoRepository<Post, String> {
    Collection<Post> findByAuthor(@Param("author") String author);
}
