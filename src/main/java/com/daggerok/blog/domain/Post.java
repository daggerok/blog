package com.daggerok.blog.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Set;
import java.util.TreeSet;

@Data
@ToString
@NoArgsConstructor
@EqualsAndHashCode
public class Post extends GenericDocument {
    private String tittle;
    private String content;
    private Set<Comment> comments = new TreeSet<>();
}
