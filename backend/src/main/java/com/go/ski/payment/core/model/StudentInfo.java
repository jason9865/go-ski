package com.go.ski.payment.core.model;

import com.go.ski.payment.support.dto.util.StudentInfoDTO;
import com.go.ski.payment.support.vo.Age;
import com.go.ski.payment.support.vo.Height;
import com.go.ski.payment.support.vo.Weight;
import com.go.ski.user.support.vo.Gender;
import com.go.ski.user.support.vo.GenderConvert;

import jakarta.persistence.Column;
import jakarta.persistence.Convert;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.*;

@Getter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class StudentInfo {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer studentInfoId;
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "lesson_id")
	private LessonInfo lessonInfo;
	@Enumerated(EnumType.STRING)
	private Height height;
	@Enumerated(EnumType.STRING)
	private Weight weight;
	@Column
	private Integer footSize;
	@Enumerated(EnumType.STRING)
	private Age age;
	@Enumerated(EnumType.STRING)
	private Gender gender;
	@Column
	private String name;

	public static StudentInfo toStudentInfoForPayment(LessonInfo lessonInfo, StudentInfoDTO studentInfoDTO) {
		return StudentInfo.builder()
			.lessonInfo(lessonInfo)
			.height(studentInfoDTO.getHeight())
			.weight(studentInfoDTO.getWeight())
			.footSize(studentInfoDTO.getFootSize())
			.age(studentInfoDTO.getAge())
			.gender(studentInfoDTO.getGender())
			.name(studentInfoDTO.getName())
			.build();
	}
}
