package com.go.ski.lesson.support.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class ReserveAdvancedRequestDTO extends ReserveNoviceRequestDTO {
    private Integer level;

    public ReserveAdvancedRequestDTO(ReserveNoviceRequestDTO reserveNoviceRequestDTO) {
        super(reserveNoviceRequestDTO);
        level = 1;
    }
}
