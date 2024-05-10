package com.go.ski.common.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.go.ski.common.response.ApiResponse;
import com.go.ski.common.service.CommonService;
import com.go.ski.team.support.dto.ResortListDTO;
import com.go.ski.user.core.model.Certificate;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/common")
public class CommonController {

	private final CommonService commonService;

	@GetMapping("/resort")
	public ResponseEntity<ApiResponse<?>> getResortList() {

		List<ResortListDTO> response = commonService.getResortList();
		return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
	}

	@GetMapping("/certificate")
	public ResponseEntity<ApiResponse<?>> getCertificate() {

		List<Certificate> response = commonService.getCertificateLsit();
		return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
	}

}
