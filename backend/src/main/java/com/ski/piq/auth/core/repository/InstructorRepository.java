package com.ski.piq.auth.core.repository;

import com.ski.piq.auth.core.model.Instructor;
import org.springframework.data.jpa.repository.JpaRepository;

public interface InstructorRepository extends JpaRepository<Instructor, Integer> {
}
