package com.go.ski.user.core.model;

import com.go.ski.user.support.vo.InstructAvailable;
import jakarta.persistence.*;
import lombok.*;
import org.springframework.data.domain.Persistable;

import static lombok.AccessLevel.PROTECTED;

@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = PROTECTED)
@Getter
@Table
public class Instructor {
    @Id
    private int userId; // User의 PK를 여기서도 PK로 사용

    @MapsId // User의 userId를 Instructor의 PK로 매핑
    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "user_id", referencedColumnName = "user_id")
    private User user;

    @Setter
    private String description;

    @Setter
    private InstructAvailable isInstructAvailable;

    @Setter
    private int dayoff;
}
