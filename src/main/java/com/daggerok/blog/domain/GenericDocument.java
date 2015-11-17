package com.daggerok.blog.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.data.annotation.Id;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@ToString
@NoArgsConstructor
@EqualsAndHashCode
public class GenericDocument implements Serializable {
    @Id
    protected String id;
    protected LocalDateTime at = LocalDateTime.now();
}
