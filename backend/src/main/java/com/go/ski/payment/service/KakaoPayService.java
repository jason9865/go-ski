package com.go.ski.payment.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.go.ski.payment.dto.request.KakaopayApproveRequestDTO;
import com.go.ski.payment.dto.request.KakaopayCancelRequestDTO;
import com.go.ski.payment.dto.response.KakaopayApproveResponseDTO;
import com.go.ski.payment.dto.request.KakaopayPrepareRequestDTO;
import com.go.ski.payment.dto.response.KakaopayCancelResponseDTO;
import com.go.ski.payment.dto.response.KakaopayPrepareResponseDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class KakaoPayService {

	//카카오 API DEVELOPER VARIABLE
	@Value("${pay.test_id}")
	public String testId;
	@Value("${pay.client_id}")
	public String clientId;
	@Value("${pay.client_secret}")
	public String clientSecret;
	@Value("${pay.secret_key}")
	public String secretKey;
	@Value("${pay.secret_key_dev}")
	public String secretKeyDev;
	private String HOST = "https://open-api.kakaopay.com/online/v1/payment";
	private final RestTemplate restTemplate = new RestTemplate();

	//결제 준비
	//클라이언트의 결제 준비 요청을 kakao 서버로 던지기 위해 변환
	public KakaopayPrepareResponseDTO getPrepareResponse(KakaopayPrepareRequestDTO request) {
		//헤더 설정 추후에 서비스 모드로 변경
		HttpHeaders headers = getHeader("test");

		Map<String, String> params = new HashMap<>();
		params.put("cid", testId);
		params.put("partner_order_id", request.getPartnerOrderId());
		params.put("partner_user_id", request.getPartnerUserId());
		params.put("item_name", request.getItemName());
		params.put("quantity", Integer.toString(request.getQuantity()));
		params.put("total_amount", Integer.toString(request.getTotalAmount()));
		params.put("tax_free_amount", Integer.toString(request.getTaxFreeAmount()));
		params.put("approval_url", request.getApprovalUrl());
		params.put("cancel_url", request.getCancelUrl());
		params.put("fail_url", request.getFailUrl());

		log.info("data : {}", params);
		HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(params, headers);
		ResponseEntity<KakaopayPrepareResponseDTO> responseEntity = restTemplate.postForEntity(HOST + "/ready", requestEntity, KakaopayPrepareResponseDTO.class);
		log.info("data : {}", responseEntity);
		return responseEntity.getBody();
	}

	//결제 요청
	/*
	 * cid : 가맹점 코드
	 * payment_method_type : 결제 수단
	 * Amount {
	 * 	total : 전체 결제 금액
	 * 	tax_free : 비과세 금액
	 *  	vat : 부가세 금액
	 *   point : 사용한 포인트 금액 (카카오 포인트)
	 *   discount : 할인 금액
	 *   green_deposit : 컵 보증금?
	 * }
	 *
	 * Card_Info
	 * 매입사 명
	 * 매입사 코드
	 * 발급사 명
	 * 발급사 코드
	 * 카드 BIN
	 * 카드 타입
	 * 할부 개월 수
	 * 카드사 승인 번호
	 * 카드사 가맹점 번호
	 * 무이자 할부 여부
	 * 할부 유형
	 * 카드 상품 코드
	 * */
	public KakaopayApproveResponseDTO getApproveResponse(KakaopayApproveRequestDTO request) {
		HttpHeaders headers = getHeader("test");

		Map<String, String> params = new HashMap<>();
		params.put("cid", testId);
		params.put("tid", request.getTid());
		params.put("partner_order_id", request.getPartnerOrderId());
		params.put("partner_user_id", request.getPartnerUserId());
		params.put("pg_token", request.getPgToken());

		log.info("params : {}", params);

		HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(params, headers);
		ResponseEntity<KakaopayApproveResponseDTO> responseEntity = restTemplate.postForEntity(HOST + "/approve", requestEntity, KakaopayApproveResponseDTO.class);
		log.info("data : {}", responseEntity);
		// 여기서 결제 정보를 db에 저장

		return responseEntity.getBody();
	}

	//결제 취소
	//환급 금액은 내가 설정
	public KakaopayCancelResponseDTO getCancelResponse(KakaopayCancelRequestDTO request) {
		HttpHeaders headers = getHeader("test");
		Map<String, String> params = new HashMap<>();
		params.put("cid", testId);
		params.put("tid", request.getTid());
		params.put("cancel_amount", String.valueOf(request.getCancelAmount()));
		params.put("cancel_tax_free_amount", String.valueOf(request.getCancelTaxFreeAmount()));

		log.info("params : {}", params);

		HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(params, headers);
		ResponseEntity<KakaopayCancelResponseDTO> responseEntity = restTemplate.postForEntity(HOST + "/approve", requestEntity, KakaopayCancelResponseDTO.class);
		log.info("data : {}", responseEntity);

		return responseEntity.getBody();
	}

	public HttpHeaders getHeader(String mode) {
		HttpHeaders headers = new HttpHeaders();

		if(mode.equals("test")) headers.add("Authorization", "SECRET_KEY " + secretKeyDev);
		else headers.add("Authorization", "SECRET_KEY " + secretKey);

		headers.add("Content-type", "application/json");

		return headers;
	}
}