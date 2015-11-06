package com.daggerok.blog.config;

import com.google.common.cache.CacheBuilder;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.CachingConfigurer;
import org.springframework.cache.annotation.EnableCaching;
//import org.springframework.cache.concurrent.ConcurrentMapCacheManager;
import org.springframework.cache.guava.GuavaCache;
//import org.springframework.cache.guava.GuavaCacheManager;
import org.springframework.cache.interceptor.*;
import org.springframework.cache.support.SimpleCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Arrays;
import java.util.concurrent.TimeUnit;
import java.util.logging.Logger;

@EnableCaching
@Configuration
public class CacheConfig implements CachingConfigurer {
    private static final Logger logger = Logger.getLogger(CacheConfig.class.getName());

    public static final String post = "post";

    public static final int maxItemsInCache = 500;

    @Bean
    @Override
    public CacheManager cacheManager() {
        /*
        GuavaCacheManager cacheManager = new GuavaCacheManager();

        cacheManager.setAllowNullValues(false);
        cacheManager.setCacheNames(Arrays.asList(post));
        cacheManager.setCacheBuilder(CacheBuilder
                .newBuilder()
                .maximumSize(maxItemsInCache)
                .expireAfterWrite(7, TimeUnit.DAYS));
        */

        SimpleCacheManager cacheManager = new SimpleCacheManager();

        cacheManager.setCaches(Arrays.asList( // add more caches here
                new GuavaCache(post, CacheBuilder.newBuilder().maximumSize(maxItemsInCache)
                        .expireAfterWrite(7, TimeUnit.DAYS).build(), false)/* ,
                new GuavaCache(news, CacheBuilder.newBuilder().maximumSize(maxItemsInCache)
                        .expireAfterWrite(1, TimeUnit.DAYS).build(), false) */
        ));
        return cacheManager;
    }

    /*
    @Bean
    public CacheManager defaultCacheManager() {
        return new ConcurrentMapCacheManager(
                post // add more
        );
    }
    */

    @Override
    public CacheResolver cacheResolver() {
        return new SimpleCacheResolver();
    }

    @Override
    public KeyGenerator keyGenerator() {
        return new SimpleKeyGenerator();
    }

    @Override
    public CacheErrorHandler errorHandler() { // Simple logged error handler
        return new CacheErrorHandler() {
            @Override
            public void handleCacheGetError(RuntimeException exception, Cache cache, Object key) {
                logger.warning(String.format("exception:'%s', cacheName:'%s', key:'%s'", exception.getMessage(),
                        cache.getName(), key));
                throw exception;
            }
            @Override
            public void handleCachePutError(RuntimeException exception, Cache cache, Object key, Object value) {
                logger.warning(String.format("exception:'%s', cacheName:'%s', key:'%s', value:'%s'",
                        exception.getMessage(), cache.getName(), key, value));
                throw exception;
            }
            @Override
            public void handleCacheEvictError(RuntimeException exception, Cache cache, Object key) {
                logger.warning(String.format("exception:'%s', cacheName:'%s', key:'%s'", exception.getMessage(),
                        cache.getName(), key));
                throw exception;
            }
            @Override
            public void handleCacheClearError(RuntimeException exception, Cache cache) {
                logger.warning(String.format("exception:'%s', cacheName:'%s'", exception.getMessage(), cache.getName()));
                throw exception;
            }
        };
    }
}
