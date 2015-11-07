package com.daggerok.blog.domain;

import lombok.*;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;

@Entity
@ToString
@Setter
@Getter
@NoArgsConstructor
@EqualsAndHashCode(exclude = "id")
public class Post {
    @Id
    @GeneratedValue
    public Long id;

    public String author, subject;

    @Column(length = Short.MAX_VALUE)
    public String body;

    @ElementCollection(targetClass = String.class)
    public Set<String> tags = new HashSet<>(); // or Map, not List

    @Column(name = "post_date", nullable = true)
    public LocalDate postDate = LocalDate.now();

    private Post(String author, String subject, String body) {
        this.author = author;
        this.subject = subject;
        this.body = body;
    }

    public static Post create(String author, String subject, String body) {
        return new Post(author, subject, body);
    }
}
