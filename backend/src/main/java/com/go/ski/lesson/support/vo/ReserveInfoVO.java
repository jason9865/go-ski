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
            case "스키" -> {
                if (reserveRequestDTO.getLevel() == null) {
                    lessonType = "1010000";
                } else {
                    switch (reserveRequestDTO.getLevel()) {
                        case "중급" -> lessonType = "1010010";
                        case "고급" -> lessonType = "1010011";
                        default -> throw new IllegalArgumentException("Invalid lesson type");
                    }
                }
            }
            case "보드" -> {
                if (reserveRequestDTO.getLevel() == null) {
                    lessonType = "1100000";
                } else {
                    switch (reserveRequestDTO.getLevel()) {
                        case "중급" -> lessonType = "1101000";
                        case "고급" -> lessonType = "1101100";
                        default -> throw new IllegalArgumentException("Invalid lesson type");
                    }
                }
            }
            case "휴일" -> lessonType = "1000000";
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
