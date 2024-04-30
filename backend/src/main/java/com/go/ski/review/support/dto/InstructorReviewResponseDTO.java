package com.go.ski.review.support.dto;

import com.go.ski.common.util.TimeConvertor;
import com.go.ski.review.support.vo.InstructorReviewVO;
import com.go.ski.review.support.vo.InstructorTagsVO;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@AllArgsConstructor
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@ToString
public class InstructorReviewResponseDTO {

    private Integer reviewId;
    private Integer lessonId;
    private LocalDate lessonDate;
    private String lessonTimeInfo;
    private String representativeName;
    private Integer rating;
    private List<InstructorTagsVO> instructorTags;

    public static InstructorReviewResponseDTO toDTO(InstructorReviewVO vo, List<InstructorTagsVO> tags) {
        return InstructorReviewResponseDTO.builder()
                .reviewId(vo.getReviewId())
                .lessonId(vo.getLessonId())
                .lessonDate(vo.getLessonDate())
                .representativeName(vo.getRepresentativeName())
                .rating(vo.getRating())
                .lessonTimeInfo(TimeConvertor.calLessonTimeInfo(vo.getStartTime(), vo.getDuration()))
                .instructorTags(tags)
                .build()
                ;
    }


}
