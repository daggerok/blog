package com.daggerok.blog.domain;

import lombok.*;

import javax.persistence.*;

@Entity
@ToString
@Setter @Getter
@NoArgsConstructor
@EqualsAndHashCode(exclude = "id")
public class User {
    @Id @GeneratedValue
    public Long id;

    public String username;

    public static User create(String username) {
        return new User(username);
    }

    private User(String username) {
        this.username = username;
    }
}
