package com.daggerok.blog.domain;

import com.daggerok.blog.config.BlogAppConfig;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = BlogAppConfig.class)
public class PostsRepositoryTest {
    @Resource
    private PostsRepository repository;

    @Test
    public void testContext() throws Exception {
        assertNotNull("repository is null", repository);
    }
}