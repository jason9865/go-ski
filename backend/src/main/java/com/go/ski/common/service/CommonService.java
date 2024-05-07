package com.go.ski.common.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.go.ski.team.core.model.SkiResort;
import com.go.ski.team.core.repository.SkiResortRepository;
import com.go.ski.team.support.dto.ResortListDTO;
import com.go.ski.user.core.model.Certificate;
import com.go.ski.user.core.repository.CertificateRepository;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CommonService {

	private final CertificateRepository certificateRepository;
	private final SkiResortRepository skiResortRepository;

	public List<ResortListDTO> getResortList() {

		return skiResortRepository.findResortList();
	}
	public List<Certificate> getCertificateLsit() {

		return certificateRepository.findAll();
	}
}
