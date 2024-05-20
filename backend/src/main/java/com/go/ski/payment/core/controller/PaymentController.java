package com.go.ski.payment.core.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.go.ski.common.response.ApiResponse;
import com.go.ski.payment.core.service.PayService;
import com.go.ski.payment.support.dto.request.ApprovePaymentRequestDTO;
import com.go.ski.payment.support.dto.request.CancelPaymentRequestDTO;
import com.go.ski.payment.support.dto.request.KakaopayApproveRequestDTO;
import com.go.ski.payment.support.dto.request.KakaopayCancelRequestDTO;
import com.go.ski.payment.support.dto.request.ReserveLessonPaymentRequestDTO;
import com.go.ski.payment.support.dto.request.VerifyAccountRequestDTO;
import com.go.ski.payment.support.dto.response.KakaopayApproveResponseDTO;
import com.go.ski.payment.support.dto.response.KakaopayCancelResponseDTO;
import com.go.ski.payment.support.dto.request.KakaopayPrepareRequestDTO;
import com.go.ski.payment.support.dto.response.KakaopayPrepareResponseDTO;
import com.go.ski.payment.core.service.KakaoPayService;
import com.go.ski.payment.support.dto.response.LessonCostResponseDTO;
import com.go.ski.payment.support.dto.response.OwnerPaymentHistoryResponseDTO;
import com.go.ski.payment.support.dto.response.UserPaymentHistoryResponseDTO;
import com.go.ski.payment.support.dto.response.VerifyAccountResponseDTO;
import com.go.ski.payment.support.dto.response.WithdrawalResponseDTO;

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
    @PostMapping("/reserve/prepare")
    public ResponseEntity<ApiResponse<?>> preparePayment(
            HttpServletRequest httpServletRequest,
            @RequestBody ReserveLessonPaymentRequestDTO request) {
        log.info("예약 준비: {}", request);
        KakaopayPrepareResponseDTO response = payService.getPrepareResponse(httpServletRequest, request);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }

    @PostMapping("/reserve/approve")
    public ResponseEntity<ApiResponse<?>> approvePayment(
            HttpServletRequest httpServletRequest,
            @RequestBody ApprovePaymentRequestDTO request) {

        KakaopayApproveResponseDTO response = payService.getApproveResponse(httpServletRequest, request);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }

    @PostMapping("/reserve/cancel")
    public ResponseEntity<?> cancelPayment(
            HttpServletRequest httpServletRequest,
            @RequestBody CancelPaymentRequestDTO request) {

        if (!payService.checkAuthorization(request.getLessonId(), httpServletRequest))
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);

        payService.getCancelResponse(request);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    @GetMapping("/history")
    public ResponseEntity<ApiResponse<?>> getUserPaymentHistory(HttpServletRequest httpServletRequest) {
        List<UserPaymentHistoryResponseDTO> response = payService.getUserPaymentHistories(httpServletRequest);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }

    @GetMapping("/history/head")
    public ResponseEntity<ApiResponse<?>> getOwnerPaymentHistory(HttpServletRequest httpServletRequest) {
        List<OwnerPaymentHistoryResponseDTO> response = payService.getOwnerPaymentHistories(httpServletRequest);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }

    @GetMapping("/history/{team_id}")
    public ResponseEntity<ApiResponse<?>> getTeamPaymentHistory(HttpServletRequest httpServletRequest
            , @PathVariable(value = "team_id") Integer teamId) {
        List<OwnerPaymentHistoryResponseDTO> response = payService.getTeamPaymentHistories(httpServletRequest, teamId);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }

    @GetMapping("/withdrawal")
    public ResponseEntity<ApiResponse<?>> getWithdrawalList(HttpServletRequest httpServletRequest) {
        List<WithdrawalResponseDTO> response = payService.getWithdrawalList(httpServletRequest);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }

    @GetMapping("/balance")
    public ResponseEntity<ApiResponse<?>> getBalance(HttpServletRequest httpServletRequest) {
        Integer response = payService.getBalance(httpServletRequest);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }

    @PostMapping("/validate_account")
    public ResponseEntity<ApiResponse<?>> verifyAccount(@RequestBody VerifyAccountRequestDTO verifyAccountRequestDTO) throws
            UnsupportedEncodingException,
            JsonProcessingException,
            InterruptedException {
        VerifyAccountResponseDTO response = payService.requestToCodeF(verifyAccountRequestDTO);

        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }

    @GetMapping("/lesson/{lesson_id}")
    public ResponseEntity<ApiResponse<?>> getLessonCost(@PathVariable(value = "lesson_id") Integer lesson_id) {
        LessonCostResponseDTO response = payService.getLessonCost(lesson_id);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }

    //pgTokenTest
    //pg 토큰 받아와야해서 이렇게 만들어봤음
    // @GetMapping("/getPg/{pg_token}")
    // public String returnPg(@PathVariable(value = "pg_token") String pgToken) {
    // 	log.info(pgToken);
    // 	return pgToken;
    // }

}

