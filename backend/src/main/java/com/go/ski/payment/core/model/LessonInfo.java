package com.go.ski.payment.core.model;

import java.time.LocalDate;

import com.go.ski.payment.support.vo.LessonType;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.MapsId;
import jakarta.persistence.OneToOne;
import lombok.Getter;

@Getter
@Entity
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
	private LessonType lessonType;
	@Column
	private Integer studentCount;
}
