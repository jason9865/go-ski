package com.go.ski.user.core.repository;

import com.go.ski.user.core.model.Instructor;
import com.go.ski.user.core.model.InstructorCert;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface InstructorCertRepository extends JpaRepository<InstructorCert, Integer> {
    List<InstructorCert> findByInstructor(Instructor instructor);

    void deleteByInstructor(Instructor instructor);
}
