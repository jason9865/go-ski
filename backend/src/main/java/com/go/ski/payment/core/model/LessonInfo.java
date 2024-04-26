package com.go.ski.payment.core.model;

import static jakarta.persistence.EnumType.*;

import java.time.LocalDate;

import com.go.ski.payment.support.dto.request.ReserveLessonPaymentRequestDTO;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.MapsId;
import jakarta.persistence.OneToOne;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
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

	public static LessonInfo toLessonInfoForPayment (ReserveLessonPaymentRequestDTO reserveLessonPaymentRequestDTO) {
		return LessonInfo.builder()
			.lessonDate(reserveLessonPaymentRequestDTO.getLessonDate())
			.startTime(reserveLessonPaymentRequestDTO.getStartTime())
			.duration(reserveLessonPaymentRequestDTO.getDuration())
			.lessonType(reserveLessonPaymentRequestDTO.getLessonType())
			.studentCount(reserveLessonPaymentRequestDTO.getStudentInfo().size())
			.build();
	}
}
