package com.go.ski.payment.core.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.MapsId;
import jakarta.persistence.OneToOne;
import lombok.Getter;

@Getter
@Entity
public class LessonPaymentInfo {
	@Id
	private Integer lessonId; //1대 1 lesson
	@MapsId
	@OneToOne
	@JoinColumn(name = "lesson_id")
	private Lesson lesson;
	@Column
	private Integer basic_fee;
	@Column
	private Integer designated_fee;
	@Column
	private Integer people_option_fee;
	@Column
	private Integer level_option_fee;
	@Column
	private Integer duration;
}
