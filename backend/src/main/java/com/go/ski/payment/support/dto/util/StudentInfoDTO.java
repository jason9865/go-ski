package com.go.ski.payment.support.dto.util;


import com.fasterxml.jackson.annotation.JsonProperty;
import com.go.ski.payment.core.model.StudentInfo;
import com.go.ski.payment.support.vo.Age;
import com.go.ski.payment.support.vo.Height;
import com.go.ski.payment.support.vo.Weight;
import com.go.ski.user.support.vo.Gender;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class StudentInfoDTO {
    @Enumerated(EnumType.STRING)
    private Height height;
    @Enumerated(EnumType.STRING)
    private Weight weight;
    private Integer footSize;
    @Enumerated(EnumType.STRING)
    private Age age;
    @Enumerated(EnumType.STRING)
    private Gender gender;
    private String name;

    public StudentInfoDTO(StudentInfo studentInfo) {
        height = studentInfo.getHeight();
        weight = studentInfo.getWeight();
        footSize = studentInfo.getFootSize();
        age = studentInfo.getAge();
        gender = studentInfo.getGender();
        name = studentInfo.getName();
    }
}
