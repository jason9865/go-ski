package com.go.ski.payment.core.repository;

import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.support.dto.response.LessonCostResponseDTO;
import com.go.ski.payment.support.dto.response.OwnerPaymentHistoryResponseDTO;
import com.go.ski.payment.support.dto.response.UserPaymentHistoryResponseDTO;
import com.go.ski.user.core.model.Instructor;
import com.go.ski.user.core.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface LessonRepository extends JpaRepository<Lesson, Integer> {
    @Query("SELECT NEW com.go.ski.payment.support.dto.response.UserPaymentHistoryResponseDTO ( "
            + "l.user.userName, t.teamName, p.paymentDate, p.paymentStatus, c.chargeName, c.studentChargeRate, p.totalAmount, "
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

    @Query("SELECT NEW com.go.ski.payment.support.dto.response.LessonCostResponseDTO ( "
            + "p.totalAmount, "
            + "c.studentChargeRate ) " // 여기서 someColumn은 Charge 엔터티의 특정 열입니다.
            + "FROM Lesson l "
            + "JOIN Payment p ON l.lessonId = p.lessonPaymentInfo.lessonId "
            + "JOIN LessonInfo li ON l.lessonId = li.lessonId "
            + "JOIN Charge c ON c.chargeId = CASE WHEN FUNCTION('DATEDIFF', li.lessonDate, CURRENT_DATE) <= 2 THEN 3 "
            + "WHEN FUNCTION('DATEDIFF', li.lessonDate, CURRENT_DATE) <= 7 THEN 2 "
            + "ELSE 1 END "
            + "WHERE l.lessonId = :lessonId ")
    LessonCostResponseDTO findLessonCost(Integer lessonId);

    List<Lesson> findByUser(User user);

    List<Lesson> findByInstructor(Instructor instructor);

    List<Lesson> findByTeamTeamId(int teamId);

    List<Lesson> findByTeamTeamIdAndInstructorInstructorId(int teamId, int instructorId);

    @Modifying
    @Query("update Lesson l set l.instructor.instructorId = :instructorId where l.lessonId = :lessonId")
    void updateInstructorId(Integer instructorId, Integer lessonId);
}