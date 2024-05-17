package com.go.ski.payment.core.repository;

import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.model.LessonInfo;
import com.go.ski.team.core.model.Team;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface LessonInfoRepository extends JpaRepository<LessonInfo, Integer> {
    List<LessonInfo> findByLessonDateAndLessonTeamAndLessonStatus(LocalDate lessonDate, Team team, Integer lessonStatus);

    List<LessonInfo> findByLessonDateAndLessonStatus(LocalDate lessonDate, Integer lessonStatus);

    Optional<LessonInfo> findByLesson(Lesson lesson);

}
