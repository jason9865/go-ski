package com.go.ski.review.core.repository;


import com.go.ski.review.core.model.Review;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReviewRepository extends JpaRepository<Review, Integer> {
}
