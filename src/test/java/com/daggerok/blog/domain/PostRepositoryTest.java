package com.daggerok.blog.domain;

import com.daggerok.blog.SpringTest;
import org.junit.Test;

import javax.annotation.Resource;

import java.time.LocalDate;
import java.util.*;

import static org.junit.Assert.*;

public class PostRepositoryTest extends SpringTest {
    @Resource
    private PostRepository repository;

    @Test
    public void testContext() throws Exception {
        assertNotNull("repository.null", repository);
    }

    @Test
    public void testDefaultCount() throws Exception {
        assertEquals("see TestData", 4, repository.count());
    }

    @Test
    public void testSave() throws Exception {
        // test create
        repository.saveAndFlush(Post.create("Maksimko", "suppapuppatopic", "minisuppaflowpoppop"));
        List<Post> posts = repository.findAll();
        assertEquals(5, posts.size());
        // test update
        posts.forEach(p -> p.postDate = LocalDate.now());
        posts.forEach(repository::saveAndFlush);
        repository.findAll().forEach(p -> assertNotNull(p.postDate));
    }
}
