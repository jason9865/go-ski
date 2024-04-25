package com.go.ski.lesson.support.dto;

import com.go.ski.lesson.support.vo.CertificateInfoVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@Setter
@ToString
public class ReserveAdvancedResponseDTO {
    private Integer instructorId;
    private Integer description;
    private String userName;
    private String position;
    private List<CertificateInfoVO> certificateInfo;
    private Double rating;
}
