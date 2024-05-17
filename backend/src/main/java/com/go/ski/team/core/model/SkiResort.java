package com.go.ski.team.core.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.*;

import static lombok.AccessLevel.PROTECTED;

@Entity
@Getter
@NoArgsConstructor(access = PROTECTED)
@ToString
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
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
    private Double longitude;

    @Builder
    public SkiResort(Integer resortId, String resortName, String resortLocation,
                     Double latitude, Double longitude){
        this.resortId = resortId;
        this.resortName = resortName;
        this.resortLocation = resortLocation;
        this.latitude = latitude;
        this.longitude = longitude;
    }

}
