package com.go.ski.payment.core.repository;

import com.go.ski.payment.core.model.LessonInfo;
import com.go.ski.payment.core.model.StudentInfo;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface StudentInfoRepository extends JpaRepository<StudentInfo, Integer> {
    List<StudentInfo> findByLessonInfo(LessonInfo lessonInfo);
}
