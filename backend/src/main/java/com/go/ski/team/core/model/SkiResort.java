package com.go.ski.team.core.model;

import jakarta.persistence.*;
import lombok.*;

import static lombok.AccessLevel.PROTECTED;

@Entity
@Getter
@AllArgsConstructor
@NoArgsConstructor(access = PROTECTED)
@Builder
@ToString
public class SkiResort {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer resortId;

    @Column(nullable = false)
    private String resortName;

    @Column(nullable = false)
    private String resortLocation;

    @Column(nullable = false)
    private Double latitude;

    @Column(nullable = false)
    private Double hardness;

}
