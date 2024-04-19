package com.ski.piq.user.core.repository;

import com.ski.piq.user.core.model.Instructor;
import org.springframework.data.jpa.repository.JpaRepository;

public interface InstructorRepository extends JpaRepository<Instructor, Integer> {
}
