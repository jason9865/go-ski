package com.go.ski.user.core.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.NoArgsConstructor;

import static lombok.AccessLevel.PROTECTED;

@Entity
@NoArgsConstructor(access = PROTECTED)
@Getter
public class Certificate {
    @Id
    private Integer certificateId;

    private String certificateName;

    private String certificateType;
}
