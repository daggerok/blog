package com.daggerok.blog;

import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.Transactional;

@Configuration
@Transactional(readOnly = false)
public class TestData {}
