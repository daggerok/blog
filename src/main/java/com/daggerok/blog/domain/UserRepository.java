package com.daggerok.blog.domain;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

// see com.daggerok.config.CacheConfig
import org.springframework.cache.annotation.*;
import java.util.List;

@CacheConfig(cacheNames = {"users"})
@RepositoryRestResource
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
