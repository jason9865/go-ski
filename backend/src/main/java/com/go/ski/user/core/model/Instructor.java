package com.go.ski.user.core.model;

import com.go.ski.user.support.vo.IsInstructAvailable;
import jakarta.persistence.*;
import lombok.*;

import static jakarta.persistence.EnumType.STRING;
import static lombok.AccessLevel.PROTECTED;

@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = PROTECTED)
@Getter
@Table
public class Instructor {
    @Id
    private int instructorId; // User의 PK를 여기서도 PK로 사용

    @MapsId // User의 userId를 Instructor의 PK로 매핑
    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "instructor_id", referencedColumnName = "user_id")
    private User user;

    @Setter
    private String description;

    @Setter
    @Enumerated(STRING)
    private IsInstructAvailable isInstructAvailable;

    @Setter
    private int dayoff;
}
