package com.daggerok.blog;

import com.daggerok.blog.config.BlogConfig;
import org.junit.runner.RunWith;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

@Transactional(readOnly = true)
@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = {BlogConfig.class})
public abstract class SpringTest {}
