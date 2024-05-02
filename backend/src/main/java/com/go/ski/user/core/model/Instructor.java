package com.go.ski.user.core.model;

import jakarta.persistence.*;
import lombok.*;

import static lombok.AccessLevel.PROTECTED;

@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = PROTECTED)
@Getter
@ToString
public class Instructor {
    @Id
    private Integer instructorId; // User의 PK를 여기서도 PK로 사용

    @MapsId // User의 userId를 Instructor의 PK로 매핑
    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "instructor_id", referencedColumnName = "user_id")
    private User user;

    @Setter
    private String description;

    @Setter
    private String isInstructAvailable;

    @Setter
    private Integer dayoff;

    public Instructor(User user, String lessonType) {
        instructorId = user.getUserId();
        this.user = user;
        switch (lessonType) {
            case "ALL" -> isInstructAvailable = "1110000";
            case "SKI" -> isInstructAvailable = "1010000";
            case "BOARD" -> isInstructAvailable = "1100000";
        }
    }
}
