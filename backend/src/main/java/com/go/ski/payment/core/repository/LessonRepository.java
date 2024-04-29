package com.go.ski.payment.core.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.support.dto.response.UserPaymentHistoryResponseDTO;

public interface LessonRepository extends JpaRepository<Lesson, Integer> {
	@Query("SELECT NEW com.go.ski.payment.support.dto.response.PaymentHistoryResponseDTO ( "
		+ "l.user.userName, t.teamName, p.paymentDate, p.paymentStatus, c.chargeName, c.studentChargeRate, p.totalAmount, "
		+ "lp.basicFee, lp.designatedFee, lp.peopleOptionFee, lp.levelOptionFee) "
		+ "FROM Lesson l "
		+ "JOIN Team t  ON t.teamId = l.team.teamId "
		+ "JOIN LessonPaymentInfo lp ON lp.lessonId = l.lessonId "
		+ "JOIN Payment p ON p.LessonPaymentInfo.lessonId = lp.lessonId "
		+ "JOIN Charge c ON p.chargeId = c.chargeId "
		// + "JOIN t.instructor i "
		+ "WHERE l.user.userId = :userId")
	List<UserPaymentHistoryResponseDTO> findStudentPaymentHistories(Integer userId);
}
// 나중에 추가 될 요소들 c.chargeName, c.serviceCharge, i.instructorName,
// join할 테이블
/*
* 	team -> teamName
*   paymnet -> 결제 일자, 결제 상태, 수수료 id, 수수료 명, 수수료
* 	lesson_payment_info -> 결제 정보들
*
		 "teamId" : team,
		 "teamName" : team,
		 "studentName" : 예약자,
		 "instructorName" : 강사 이름 Null 가능, -> 나중에 바껴야할 수도
		 	"paymentInfo" : {
				 "totalAmount" : Integer,
				 "paymentDate" : String,
				 "paymentStatus" : Integer,
			 },
		"chargeName" : String,
		"charge" : Integer
		"lessonPaymentInfo" : {
		 "basicFee" : Integer,
		"designatedFee" : Integer,
					 "peopleOptionFee" : Integer,
					 "levelOptionFee" : Integer
				 }
			 },
* */