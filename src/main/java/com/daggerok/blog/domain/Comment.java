package com.daggerok.blog.domain;

import lombok.*;

@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@RequiredArgsConstructor(staticName = "of")
public class Comment extends Doc {
    @NonNull private String author;
    @NonNull private String content;
}
