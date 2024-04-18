package com.ski.piq.user.core.model;

import com.ski.piq.user.support.vo.Gender;
import com.ski.piq.user.support.vo.Role;
import com.ski.piq.auth.oauth.dto.Domain;
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
@Table(name = "user",
        uniqueConstraints = {
                @UniqueConstraint(
                        name = "domain_unique",
                        columnNames = {
                                "domain_user_key",
                                "domain_name"
                        }
                ),
        }
)
@Check(constraints = "phone_number REGEXP '^[0-9]{3}-[0-9]{4}-[0-9]{4}$'")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int userId;

    @Embedded
    private Domain domain;

    @Setter
    @Column(nullable = false, columnDefinition = "VARCHAR(20) CHARACTER SET UTF8")
    private String name;

    @Setter
    @Column(nullable = false)
    private Timestamp birthDate;

    @Setter
    @Column(nullable = false, columnDefinition = "VARCHAR(11)")
    private String phoneNumber;

    @Setter
    private String profileUrl;

    @Setter
    @Enumerated(STRING)
    @Column(nullable = false)
    private Gender gender;

    @Setter
    @Enumerated(STRING)
    @Column(nullable = false)
    private Role role;

    private String fcmWeb;
    private String fcmMobile;

    private LocalDateTime createdDate;

    // User와 Instructor는 1대1 관계
    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private Instructor instructor;

    @PrePersist
    protected void onCreate() {
        createdDate = LocalDateTime.now();
    }
}