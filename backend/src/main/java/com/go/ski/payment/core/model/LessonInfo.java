package com.go.ski.payment.core.model;

import static jakarta.persistence.EnumType.*;

import java.time.LocalDate;

import com.go.ski.payment.support.dto.request.ReserveLessonPaymentRequestDTO;

import com.go.ski.lesson.support.vo.ReserveInfoVO;
import com.go.ski.payment.support.dto.request.ReserveLessonPaymentRequestDTO;
import com.go.ski.user.core.model.Instructor;
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
	// @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer lessonId;// pk 1대 1 lesson fk
	@MapsId
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "lesson_id")
	private Lesson lesson;
	@Column
	private LocalDate lessonDate;
	@Column
	private String startTime;
	@Column
	private Integer duration;
	@Column
	private String lessonType;
	@Column
	private Integer studentCount;
	@Column
	private String requestComplain;
	@Column
	private Integer lessonStatus;

	public static LessonInfo toLessonInfoForPayment (ReserveLessonPaymentRequestDTO reserveLessonPaymentRequestDTO) {
		return LessonInfo.builder()
			.lessonDate(reserveLessonPaymentRequestDTO.getLessonDate())
			.startTime(reserveLessonPaymentRequestDTO.getStartTime())
			.duration(reserveLessonPaymentRequestDTO.getDuration())
			.lessonType(reserveLessonPaymentRequestDTO.getLessonType())
			.studentCount(reserveLessonPaymentRequestDTO.getStudentInfo().size())
			.build();
	}
    
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

    public LessonInfo(Instructor instructor, ReserveInfoVO reserveInfoVO) {
        lesson = Lesson.builder().instructor(instructor).build();
        lessonDate = reserveInfoVO.getLessonDate();
        startTime = reserveInfoVO.getStartTime();
        duration = reserveInfoVO.getDuration();
        studentCount = reserveInfoVO.getStudentCount();
        lessonType = reserveInfoVO.getLessonType();
    }

	public LessonInfo(Lesson lesson, ReserveInfoVO reserveInfoVO) {
		this.lesson = lesson;
		lessonDate = reserveInfoVO.getLessonDate();
		startTime = reserveInfoVO.getStartTime();
		duration = reserveInfoVO.getDuration();
		studentCount = reserveInfoVO.getStudentCount();
		lessonType = reserveInfoVO.getLessonType();
	}
}
