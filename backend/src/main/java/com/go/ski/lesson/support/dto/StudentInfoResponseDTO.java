package com.go.ski.lesson.support.dto;

import com.go.ski.payment.core.model.StudentInfo;
import com.go.ski.payment.support.vo.Age;
import com.go.ski.payment.support.vo.Height;
import com.go.ski.payment.support.vo.Weight;
import com.go.ski.user.support.vo.Gender;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class StudentInfoResponseDTO {
    private Integer studentInfoId;
    private Height height;
    private Weight weight;
    private Integer footSize;
    private Age age;
    private Gender gender;
    private String name;

    public StudentInfoResponseDTO(StudentInfo studentInfo) {
        studentInfoId = studentInfo.getStudentInfoId();
        height = studentInfo.getHeight();
        weight = studentInfo.getWeight();
        footSize = studentInfo.getFootSize();
        age = studentInfo.getAge();
        gender = studentInfo.getGender();
        name = studentInfo.getName();
    }
}
