package com.go.ski.payment.support.dto.util;


import com.fasterxml.jackson.annotation.JsonProperty;
import com.go.ski.payment.core.model.StudentInfo;
import com.go.ski.user.support.vo.Gender;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class StudentInfoDTO {
    @Enumerated(EnumType.STRING)
    private String height;
    @Enumerated(EnumType.STRING)
    private String weight;
    @JsonProperty("foot_size")
    private Integer footSize;
    @Enumerated(EnumType.STRING)
    private String age;
    @Enumerated(EnumType.STRING)
    private Gender gender;
    private String name;

    public StudentInfoDTO(StudentInfo studentInfo) {
        height = String.valueOf(studentInfo.getHeight());
        weight = String.valueOf(studentInfo.getWeight());
        footSize = studentInfo.getFootSize();
        age = String.valueOf(studentInfo.getAge());
        gender = studentInfo.getGender();
        name = studentInfo.getName();
    }
}
