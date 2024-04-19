package com.go.ski.user.core.repository;

import com.go.ski.user.core.model.Instructor;
import org.springframework.data.jpa.repository.JpaRepository;

public interface InstructorRepository extends JpaRepository<Instructor, Integer> {
}
