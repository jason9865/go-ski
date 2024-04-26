package com.go.ski.payment.core.model;

import com.go.ski.lesson.support.dto.ReserveAdvancedRequestDTO;
import com.go.ski.payment.support.dto.request.ReserveLessonPaymentRequestDTO;
import com.go.ski.payment.support.vo.LessonType;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;

@Getter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class LessonInfo {
    @Id
    private Integer lessonId;// pk 1대 1 lesson fk
    @MapsId
    @OneToOne
    @JoinColumn(name = "lesson_id")
    private Lesson lesson;
    @Column
    private LocalDate lessonDate;
    @Column
    private String startTime;
    @Column
    private Integer duration;
    @Column
    @Enumerated(EnumType.STRING)
    private LessonType lessonType;
    @Column
    private Integer studentCount;

    public static LessonInfo toLessonForPayment(Lesson lesson, ReserveLessonPaymentRequestDTO reserveLessonPaymentRequestDTO) {
        return LessonInfo.builder()
                .lessonId(lesson.getLessonId())
                .lesson(lesson)
                .lessonDate(reserveLessonPaymentRequestDTO.getLessonDate())
                .startTime(reserveLessonPaymentRequestDTO.getStartTime())
                .duration(reserveLessonPaymentRequestDTO.getDuration())
                .lessonType(reserveLessonPaymentRequestDTO.getLessonType())
                .studentCount(reserveLessonPaymentRequestDTO.getStudentInfo().size())
                .build();
    }

    public LessonInfo(Instructor instructor, ReserveAdvancedRequestDTO reserveAdvancedRequestDTO) {
        lesson = Lesson.builder().instructor(instructor).build();
        lessonType = reserveAdvancedRequestDTO.getLessonType();
        lessonDate = reserveAdvancedRequestDTO.getLessonDate();
        startTime = reserveAdvancedRequestDTO.getStartTime();
        studentCount = reserveAdvancedRequestDTO.getStudentCount();
        duration = reserveAdvancedRequestDTO.getDuration();
    }
}
