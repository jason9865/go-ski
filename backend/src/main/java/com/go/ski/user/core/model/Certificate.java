package com.go.ski.user.core.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Getter;

@Entity
@Getter
public class Certificate {
    @Id
    private Integer certificateId;

    private String certificateName;

    private String certificateType;
}
