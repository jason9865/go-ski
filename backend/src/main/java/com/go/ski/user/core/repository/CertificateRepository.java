package com.go.ski.user.core.repository;

import com.go.ski.user.core.model.Certificate;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CertificateRepository extends JpaRepository<Certificate, Integer> {
}
