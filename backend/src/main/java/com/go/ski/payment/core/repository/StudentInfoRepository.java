package com.go.ski.payment.core.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.go.ski.payment.core.model.StudentInfo;

public interface StudentInfoRepository extends JpaRepository<StudentInfo, Integer> {
}
