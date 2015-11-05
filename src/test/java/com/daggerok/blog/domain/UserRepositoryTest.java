package com.daggerok.blog.domain;

import com.daggerok.blog.SpringTest;
import org.junit.Before;
import org.junit.Test;

import javax.annotation.Resource;

import static org.junit.Assert.*;

public class UserRepositoryTest extends SpringTest {
    @Resource
    private UserRepository repository;

    @Before
    public void setUp() throws Exception {}

    @Test
    public void testContext() throws Exception {
        assertNotNull("repository.null", repository);
    }

    @Test
    public void testCount() throws Exception {
        assertEquals("repository.count", 4, repository.count());

        User res = repository.findOne(1L);
        assertNotNull(res.username);
    }
}
