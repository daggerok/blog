package com.daggerok.blog.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.*;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
@EqualsAndHashCode(exclude = {"id", "at"})
@RequiredArgsConstructor(staticName = "of")
@JsonIgnoreProperties(ignoreUnknown = true)
public class Comment extends Doc {
    @NonNull private String author;
    @NonNull private String content;
}
