package com.daggerok.blog.domain;

import lombok.*;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Set;
import java.util.TreeSet;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@RequiredArgsConstructor(staticName = "of")
@Document(collection = "posts", language = "java")
public class Post extends Doc {
    @NonNull private String author;
    @NonNull private String tittle;
    @NonNull private String content;
    private Set<Comment> comments = new TreeSet<>();
}
