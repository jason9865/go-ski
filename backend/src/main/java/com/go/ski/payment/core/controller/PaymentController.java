package com.go.ski.payment.core.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.go.ski.payment.core.service.PayService;
import com.go.ski.payment.support.dto.request.KakaopayApproveRequestDTO;
import com.go.ski.payment.support.dto.request.KakaopayCancelRequestDTO;
import com.go.ski.payment.support.dto.request.ReserveLessonPaymentRequestDTO;
import com.go.ski.payment.support.dto.response.KakaopayApproveResponseDTO;
import com.go.ski.payment.support.dto.response.KakaopayCancelResponseDTO;
import com.go.ski.payment.support.dto.request.KakaopayPrepareRequestDTO;
import com.go.ski.payment.support.dto.response.KakaopayPrepareResponseDTO;
import com.go.ski.payment.core.service.KakaoPayService;
import com.go.ski.payment.support.dto.response.ReserveLessonPaymentResponseDTO;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/payment")
public class PaymentController {

	private final PayService payService;
	private final KakaoPayService kakaoPayService;

	//결제 준비
	@PostMapping("/charge")
	public ResponseEntity<KakaopayPrepareResponseDTO> preparePayment(@RequestBody KakaopayPrepareRequestDTO request) {
		KakaopayPrepareResponseDTO response = kakaoPayService.getPrepareResponse(request);
		log.info("value : {}", response);
		return ResponseEntity.ok().body(response);
	}
	//결제 승인
	@PostMapping("/approve")
	public ResponseEntity<KakaopayApproveResponseDTO> approvePayment(@RequestBody KakaopayApproveRequestDTO request) {
		KakaopayApproveResponseDTO response = kakaoPayService.getApproveResponse(request);
		return ResponseEntity.ok().body(response);
	}

	//결제 취소
	@PostMapping("/cancel")
	public ResponseEntity<KakaopayCancelResponseDTO> cancelPayment(@RequestBody KakaopayCancelRequestDTO request) {
		KakaopayCancelResponseDTO response = kakaoPayService.getCancelResponse(request);
		return ResponseEntity.ok().body(response);
	}
	//강습 예약 결제 API -> 요청 uri 나중에 페이 연동 많아지면 domain 추가

	//결제의 단계가 준비랑, 승인임
	@PostMapping("/reserve")
	public ResponseEntity<KakaopayPrepareResponseDTO> testPreparePayment(
		HttpServletRequest httpServletRequest,
		@RequestBody ReserveLessonPaymentRequestDTO request) {
		
		log.info(request.toString());
		KakaopayPrepareResponseDTO response = payService.getResponse(httpServletRequest, request);
		return ResponseEntity.ok().body(response);
	}

	//pgTokenTest
	//pg 토큰 받아와야해서 이렇게 만들어봤음
	// @GetMapping("/getPg/{pg_token}")
	// public String returnPg(@PathVariable(value = "pg_token") String pgToken) {
	// 	log.info(pgToken);
	// 	return pgToken;
	// }

}

