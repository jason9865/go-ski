package com.go.ski.user.core.model;

import com.go.ski.user.support.vo.Gender;
import com.go.ski.user.support.vo.Role;
import com.go.ski.auth.oauth.dto.Domain;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.Check;

import java.sql.Timestamp;
import java.time.LocalDateTime;

import static jakarta.persistence.EnumType.STRING;
import static lombok.AccessLevel.PROTECTED;

@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = PROTECTED)
@Getter
@Table
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int userId;

    @Embedded
    private Domain domain;

    @Setter
    private String userName;

    @Setter
    private LocalDateTime birthDate;

    @Setter
    private String phoneNumber;

    @Setter
    private String profileUrl;

    @Setter
    @Enumerated(STRING)
    private Gender gender;

    @Setter
    @Enumerated(STRING)
    private Role role;

    private String fcmWeb;
    private String fcmMobile;

    private LocalDateTime createdDate;
    private LocalDateTime expiredDate;

    @PrePersist
    protected void onCreate() {
        createdDate = LocalDateTime.now();
    }
}