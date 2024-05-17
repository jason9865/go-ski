package com.go.ski.payment.core.model;

import com.go.ski.team.core.model.Team;
import com.go.ski.user.core.model.Instructor;
import com.go.ski.user.core.model.User;
import jakarta.persistence.*;
import lombok.*;

@Getter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Lesson {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer lessonId;//pk
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;//다 대 1 user fk
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "team_id")
    private Team team;// 다 대 1 team fk
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "instructor_id")
    private Instructor instructor;// 다 대 1 team fk
    @Column
    private Integer isOwn;//자체 강의 or 외부 강의
    @Column
    private String representativeName;// 대표자 이름

    // @OneToOne(mappedBy = "lesson")
    // private LessonInfo lessonInfo;
    // @OneToOne(mappedBy = "lesson")
    // private LessonPaymentInfo lessonPaymentInfo;
    //payload에 들어갈 내용
    //lesson id, 대표자 이름,
    public static Lesson toLessonForPayment(User user, Team team, Instructor instructor, Integer isOwn) {
        return Lesson.builder()
                .user(user)
                .team(team)
                .instructor(instructor)
                .isOwn(isOwn)
                .representativeName(user.getUserName())
                .build();
    }

    public Lesson(Integer lessonId, User user, Team team, Instructor instructor, String representativeName) {
        this.lessonId = lessonId;
        this.user = user;
        this.team = team;
        this.instructor = instructor;
        isOwn = 1;
        this.representativeName = representativeName;
    }
}
