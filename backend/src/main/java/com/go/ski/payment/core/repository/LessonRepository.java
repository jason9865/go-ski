package com.go.ski.payment.core.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.go.ski.payment.core.model.Lesson;

public interface LessonRepository extends JpaRepository<Lesson, Integer> {
}
