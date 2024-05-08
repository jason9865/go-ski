package com.go.ski.lesson.support.vo;

import com.go.ski.lesson.support.dto.ReserveRequestDTO;
import com.go.ski.lesson.support.dto.ReserveRequestFrameDTO;
import com.go.ski.payment.core.model.LessonInfo;
import com.go.ski.redis.dto.PaymentCacheDto;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class ReserveInfoVO extends ReserveRequestFrameDTO {
    private String lessonType;

    public ReserveInfoVO(ReserveRequestDTO reserveRequestDTO) {
        super(reserveRequestDTO);
        switch (reserveRequestDTO.getLessonType()) {
            case "SKI" -> {
                if (reserveRequestDTO.getLevel() == null || reserveRequestDTO.getLevel().equals("BEGINNER")) {
                    lessonType = "1010000";
                } else {
                    switch (reserveRequestDTO.getLevel()) {
                        case "INTERMEDIATE" -> lessonType = "1010010";
                        case "ADVANCED" -> lessonType = "1010011";
                        default -> throw new IllegalArgumentException("Invalid lesson type");
                    }
                }
            }
            case "BOARD" -> {
                if (reserveRequestDTO.getLevel() == null || reserveRequestDTO.getLevel().equals("BEGINNER")) {
                    lessonType = "1100000";
                } else {
                    switch (reserveRequestDTO.getLevel()) {
                        case "INTERMEDIATE" -> lessonType = "1101000";
                        case "ADVANCED" -> lessonType = "1101100";
                        default -> throw new IllegalArgumentException("Invalid lesson type");
                    }
                }
            }
            case "DAYOFF" -> lessonType = "1000000";
            default -> throw new IllegalArgumentException("Invalid lesson type");
        }
    }

    public ReserveInfoVO(PaymentCacheDto paymentCacheDto) {
        super(paymentCacheDto);
        lessonType = paymentCacheDto.getLessonInfo().getLessonType();
    }

    public ReserveInfoVO(LessonInfo lessonInfo) {
        super(lessonInfo);
        lessonType = lessonInfo.getLessonType();
    }
}
