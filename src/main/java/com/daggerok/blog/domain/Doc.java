package com.daggerok.blog.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.springframework.data.annotation.Id;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@ToString
@EqualsAndHashCode(exclude = {"id", "at"})
public class Doc implements Serializable {
    @Id
    protected String id;
    protected LocalDateTime at = LocalDateTime.now();
}
