package com.go.ski.user.core.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import static lombok.AccessLevel.PROTECTED;

@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = PROTECTED)
@Getter
@Table
public class InstructorCert {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int instCertId;

    @ManyToOne
    @JoinColumn(name = "instructor_id")
    private Instructor instructor;

    @ManyToOne
    @JoinColumn(name = "certificate_id")
    private Certificate certificate;

    private String certificateImageUrl;
}
