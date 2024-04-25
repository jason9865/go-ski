package com.go.ski.payment.core.repository;

import com.go.ski.payment.core.model.Lesson;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LessonRepository extends JpaRepository<Lesson, Integer> {
}
