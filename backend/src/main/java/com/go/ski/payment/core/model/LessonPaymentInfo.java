package com.go.ski.payment.core.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.MapsId;
import jakarta.persistence.OneToOne;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

@Getter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class LessonPaymentInfo {
	@Id
	private Integer lessonId; //1대 1 lesson
	@MapsId
	@OneToOne
	@JoinColumn(name = "lesson_id")
	private Lesson lesson;
	@Column
	private Integer basicFee;
	@Column
	private Integer designatedFee;
	@Column
	private Integer peopleOptionFee;
	@Column
	private Integer levelOptionFee;
	@Column
	private Integer duration;

}