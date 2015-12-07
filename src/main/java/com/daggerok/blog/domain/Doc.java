package com.daggerok.blog.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NonNull;
import lombok.ToString;
import org.springframework.data.annotation.Id;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@ToString
@EqualsAndHashCode(exclude = "at")
@JsonIgnoreProperties(ignoreUnknown = true)
public class Doc implements Serializable {
    @Id protected String id;
    @NonNull protected LocalDateTime at = LocalDateTime.now();
}
