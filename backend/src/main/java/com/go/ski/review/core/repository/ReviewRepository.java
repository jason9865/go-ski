package com.go.ski.review.core.repository;


import com.go.ski.payment.core.model.Lesson;
import com.go.ski.review.core.model.Review;
import com.go.ski.review.support.vo.InstructorReviewVO;
import com.go.ski.team.core.model.Team;
import com.go.ski.user.core.model.Instructor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ReviewRepository extends JpaRepository<Review, Integer> {

    List<Review> findByLesson(Lesson lesson);

    @Query("SELECT new com.go.ski.review.support.vo.InstructorReviewVO(" +
            "r.reviewId, li.lessonId, li.lessonDate, li.startTime, li.duration, l.representativeName, " +
            "r.rating, r.contents, r.createdAt) " +
            "FROM Lesson l " +
            "LEFT OUTER JOIN LessonInfo li " +
            "ON l.lessonId = li.lessonId " +
            "JOIN Review r " +
            "ON l.lessonId = r.lesson.lessonId " +
            "WHERE l.instructor = :instructor")
    List<InstructorReviewVO> findByInstructor(Instructor instructor);

    List<Review> findByLessonTeam(Team team);
    List<Review> findByLessonInstructor(Instructor instructor);

}
