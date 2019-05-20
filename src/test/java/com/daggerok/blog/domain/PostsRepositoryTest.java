package com.daggerok.blog.domain;

import com.daggerok.blog.config.Cfg;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.HashSet;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = {Cfg.class})
public class PostsRepositoryTest {
    @Resource
    private PostsRepository repository;

    @Test
    public void testContext() throws Exception {
        assertNotNull("repository is null", repository);

        Post post = Post.of("Max", "cool post!", "col content!");
        post.setComments(new HashSet<>(Arrays.asList(
                Comment.of("anonymous", "bla-bla-bla2"),
                Comment.of("commenter", "cool!"),
                Comment.of("bad commenter ", "shit"),
                Comment.of("author ", "fu*k u, bad commenter :)")
        )));
        Post saved = repository.save(post);

        System.out.println("saved: " + saved);
        assertEquals(post, saved);
    }
}