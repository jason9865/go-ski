package com.go.ski.payment.core.repository;

import java.util.List;

import com.go.ski.payment.core.model.Lesson;
import com.go.ski.user.core.model.Instructor;
import com.go.ski.user.core.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import com.go.ski.payment.support.dto.response.OwnerPaymentHistoryResponseDTO;
import com.go.ski.payment.support.dto.response.UserPaymentHistoryResponseDTO;

public interface LessonRepository extends JpaRepository<Lesson, Integer> {
	@Query("SELECT NEW com.go.ski.payment.support.dto.response.UserPaymentHistoryResponseDTO ( "
		+ "l.user.userName, t.teamName, p.paymentDate, c.chargeName, c.studentChargeRate, p.totalAmount, "
		+ "lp.basicFee, lp.designatedFee, lp.peopleOptionFee, lp.levelOptionFee) "
		+ "FROM Lesson l "
		+ "JOIN Team t  ON t.teamId = l.team.teamId "
		+ "JOIN LessonPaymentInfo lp ON lp.lessonId = l.lessonId "
		+ "JOIN Payment p ON p.lessonPaymentInfo.lessonId = lp.lessonId "
		+ "JOIN Charge c ON p.chargeId = c.chargeId "
		// + "JOIN t.instructor i "
		+ "WHERE l.user.userId = :userId")
	List<UserPaymentHistoryResponseDTO> findStudentPaymentHistories(Integer userId);

	@Query("SELECT NEW com.go.ski.payment.support.dto.response.OwnerPaymentHistoryResponseDTO ( "
		+ "t.teamName, l.user.userName, p.paymentDate, c.chargeName, c.ownerChargeRate, "
		+ "p.totalAmount, lp.basicFee, lp.designatedFee, lp.peopleOptionFee, lp.levelOptionFee) "
		+ "FROM Team t "
		+ "JOIN Lesson l ON l.team.teamId = t.teamId "
		+ "JOIN LessonPaymentInfo lp ON lp.lessonId = l.lessonId "
		+ "JOIN Payment p ON p.lessonPaymentInfo.lessonId = lp.lessonId  "
		+ "JOIN Charge c ON p.chargeId = c.chargeId "
		+ "WHERE t.user.userId = :userId")
	List<OwnerPaymentHistoryResponseDTO> findOwnerPaymentHistories(Integer userId);

	@Query("SELECT NEW com.go.ski.payment.support.dto.response.OwnerPaymentHistoryResponseDTO ( "
		+ "t.teamName, l.user.userName, p.paymentDate, c.chargeName, c.ownerChargeRate, "
		+ "p.totalAmount, lp.basicFee, lp.designatedFee, lp.peopleOptionFee, lp.levelOptionFee) "
		+ "FROM Team t "
		+ "JOIN Lesson l ON l.team.teamId = t.teamId "
		+ "JOIN LessonPaymentInfo lp ON lp.lessonId = l.lessonId "
		+ "JOIN Payment p ON p.lessonPaymentInfo.lessonId = lp.lessonId  "
		+ "JOIN Charge c ON p.chargeId = c.chargeId "
		+ "WHERE t.teamId = :teamId")
	List<OwnerPaymentHistoryResponseDTO> findTeamPaymentHistories(Integer teamId);

	List<Lesson> findByUser(User user);

	List<Lesson> findByInstructor(Instructor instructor);

	List<Lesson> findByTeamTeamId(int teamId);

	List<Lesson> findByTeamTeamIdAndInstructorInstructorId(int teamId, int instructorId);
}