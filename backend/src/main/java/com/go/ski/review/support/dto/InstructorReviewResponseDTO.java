package com.go.ski.review.support.dto;

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
                .lessonTimeInfo(calLessonTimeInfo(vo))
                .instructorTags(tags)
                .build()
                ;
    }

    private static String calLessonTimeInfo(InstructorReviewVO vo) {

        String newStartTime = calNewStartTime(vo);
        String newEndTime = calNewEndTime(vo);
        return newStartTime + " ~ " + newEndTime;
    }

    private static String calNewStartTime(InstructorReviewVO instructorReview) {
        String startTime = instructorReview.getStartTime();
        return startTime.length() == 4 ?
                startTime.substring(0,2) + ":" + startTime.substring(2,4) :
                startTime.charAt(0) + ":" + startTime.substring(1,3);
    }

    private static String calNewEndTime(InstructorReviewVO instructorReview) {
        // startTime과 duration으로부터 endTime 계산
        String startTime = instructorReview.getStartTime();
        Integer duration = instructorReview.getDuration();
        String endTime = String.valueOf(Integer.parseInt(startTime) + duration * 100);
        return endTime.length() == 4 ?
                endTime.substring(0,2) + ":" + endTime.substring(2,4) :
                endTime.charAt(0) + ":" + endTime.substring(1,3);
    }

}
