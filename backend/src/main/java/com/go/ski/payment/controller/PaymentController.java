package com.go.ski.payment.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.go.ski.payment.dto.request.KakaopayApproveRequestDTO;
import com.go.ski.payment.dto.request.KakaopayCancelRequestDTO;
import com.go.ski.payment.dto.response.KakaopayApproveResponseDTO;
import com.go.ski.payment.dto.response.KakaopayCancelResponseDTO;
import com.go.ski.payment.dto.request.KakaopayPrepareRequestDTO;
import com.go.ski.payment.dto.response.KakaopayPrepareResponseDTO;
import com.go.ski.payment.service.KakaoPayService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/payment")
public class PaymentController {

	private final KakaoPayService kakaoPayService;

	//결제 준비
	@PostMapping("/charge")
	public ResponseEntity<KakaopayPrepareResponseDTO> preparePayment(@RequestBody KakaopayPrepareRequestDTO request) {
		KakaopayPrepareResponseDTO resp = kakaoPayService.getPrepareResponse(request);
		log.info("value : {}", resp);
		return ResponseEntity.ok().body(resp);
	}
	//결제 승인
	@PostMapping("/approve")
	public ResponseEntity<KakaopayApproveResponseDTO> approvePayment(@RequestBody KakaopayApproveRequestDTO request) {
		KakaopayApproveResponseDTO resp = kakaoPayService.getApproveResponse(request);
		return ResponseEntity.ok().body(resp);
	}

	//결제 취소
	@PostMapping("/cancel")
	public ResponseEntity<KakaopayCancelResponseDTO> cancelPayment(@RequestBody KakaopayCancelRequestDTO request) {
		KakaopayCancelResponseDTO resp = kakaoPayService.getCancelResponse(request);
		return ResponseEntity.ok().body(resp);
	}
	//pgTokenTest
	//pg 토큰 받아와야해서 이렇게 만들어봤음
	// @GetMapping("/getPg/{pg_token}")
	// public String returnPg(@PathVariable(value = "pg_token") String pgToken) {
	// 	log.info(pgToken);
	// 	return pgToken;
	// }

}

