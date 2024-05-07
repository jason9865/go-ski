package com.go.ski.common.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.go.ski.common.service.CommonService;
import com.go.ski.common.support.dto.ResortResponseDTO;
import com.go.ski.team.core.model.SkiResort;
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
	public ResponseEntity<List<SkiResort>> getResortList() {

		List<SkiResort> result = commonService.getResortList();
		return ResponseEntity.ok().body(result);
	}

	@GetMapping("/certificate")
	public ResponseEntity<List<Certificate>> getCertificate() {

		List<Certificate> result = commonService.getCertificateLsit();
		return ResponseEntity.ok().body(result);
	}

}
