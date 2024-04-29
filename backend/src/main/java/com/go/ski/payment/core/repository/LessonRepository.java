package com.go.ski.payment.core.repository;

import com.go.ski.payment.core.model.Lesson;
import com.go.ski.user.core.model.Instructor;
import com.go.ski.user.core.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface LessonRepository extends JpaRepository<Lesson, Integer> {
    List<Lesson> findByUser(User user);

    List<Lesson> findByInstructor(Instructor instructor);

    List<Lesson> findByTeamTeamId(int teamId);

    List<Lesson> findByTeamTeamIdAndInstructorInstructorId(int teamId, int instructorId);
}
