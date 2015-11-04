package com.daggerok.blog.domain;

import org.springframework.cache.annotation.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import java.util.List;

@RepositoryRestResource
@CacheConfig(cacheNames = {"users"})
public interface UserRepository extends JpaRepository<User, Long> {
    @Override
    @CachePut(key = "#entity.id")
    <S extends User> S save(S entity);

    @Override
    @Cacheable
    List<User> findAll();

    @Override
    @Cacheable
    long count();

    @Override
    @CacheEvict
    void delete(User entity);

    @Override
    @CacheEvict(allEntries = true)
    void deleteAll();
}
