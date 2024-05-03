package com.go.ski.payment.core.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.go.ski.payment.core.model.LessonPaymentInfo;
import com.go.ski.payment.core.model.Payment;
import com.go.ski.payment.support.dto.util.TotalPaymentDTO;

public interface PaymentRepository extends JpaRepository<Payment, Integer> {

	@Query("SELECT NEW com.go.ski.payment.support.dto.util.TotalPaymentDTO ( "
		+ "p.totalAmount, c.ownerChargeRate) "
		+ "FROM Team t "
		+ "JOIN Lesson l ON t.teamId = l.team.teamId "
		+ "JOIN LessonInfo li ON l.lessonId = li.lessonId "
		+ "JOIN LessonPaymentInfo lp ON l.lessonId = lp.lessonId "
		+ "JOIN Payment p ON lp.lessonId = p.lessonPaymentInfo.lessonId "
		+ "JOIN Charge c ON p.chargeId = c.chargeId "
		+ "WHERE t.user.userId = :userId AND li.lessonDate < CURRENT_DATE "
		+ "ORDER BY l.lessonId DESC ")
	List<TotalPaymentDTO> findTotalPayment(Integer userId);

	Payment findByLessonPaymentInfoLessonId(Integer lessonId);
}

