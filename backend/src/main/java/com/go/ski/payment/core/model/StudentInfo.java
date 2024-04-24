package com.go.ski.payment.core.model;

import static jakarta.persistence.EnumType.*;

import com.go.ski.payment.support.vo.Age;
import com.go.ski.payment.support.vo.Height;
import com.go.ski.payment.support.vo.Weight;
import com.go.ski.user.support.vo.Gender;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
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
public class StudentInfo {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer studentInfoId;
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "lesson_id")
	private LessonInfo lessonInfo;
	@Enumerated(STRING)
	private Height height;
	@Enumerated(STRING)
	private Weight weight;
	@Column
	private Integer footSize;
	@Enumerated(STRING)
	private Age age;
	@Enumerated(STRING)
	private Gender gender;
	@Column
	private String name;
}
