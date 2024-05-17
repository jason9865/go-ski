package com.go.ski.redis.dto;

import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.redis.core.RedisHash;

import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.model.LessonInfo;
import com.go.ski.payment.core.model.LessonPaymentInfo;
import com.go.ski.payment.core.model.StudentInfo;
import com.go.ski.payment.support.dto.util.StudentInfoDTO;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

@Getter
@RedisHash(value = "paymentCache", timeToLive = 900)
@AllArgsConstructor
@Builder
public class PaymentCacheDto {

	@Id
	private String tid;//결제 아이디

	private Lesson lesson;
	private LessonInfo lessonInfo;
	private LessonPaymentInfo lessonPaymentInfo;
	private List<StudentInfoDTO> studentInfos;
}
