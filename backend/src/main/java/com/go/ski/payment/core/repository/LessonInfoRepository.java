package com.go.ski.payment.core.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.go.ski.payment.core.model.LessonInfo;

public interface LessonInfoRepository extends JpaRepository<LessonInfo, Integer> {
}
