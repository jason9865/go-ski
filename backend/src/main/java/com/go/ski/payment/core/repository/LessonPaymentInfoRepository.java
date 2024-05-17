package com.go.ski.payment.core.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.go.ski.payment.core.model.LessonPaymentInfo;

public interface LessonPaymentInfoRepository extends JpaRepository<LessonPaymentInfo, Integer> {

	LessonPaymentInfo findByLessonId(Integer lessonId);
}
