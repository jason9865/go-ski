package com.go.ski.feedback.support.dto;

import com.go.ski.feedback.core.model.Feedback;
import com.go.ski.feedback.core.model.FeedbackMedia;
import com.go.ski.feedback.support.vo.FeedbackMediaVO;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class FeedbackResponseDTO {

    private Integer feedbackId;
    private String content;
    private final List<FeedbackMediaVO> images = new ArrayList<>();
    private final List<FeedbackMediaVO> videos = new ArrayList<>();

    public static FeedbackResponseDTO toDTO(Feedback feedback) {
        FeedbackResponseDTO dto = new FeedbackResponseDTO();
        dto.feedbackId = feedback.getFeedbackId();
        dto.content = feedback.getContent();

        for (FeedbackMedia feedbackMedia : feedback.getFeedbackMedia()){
            FeedbackMediaVO feedbackMediaVO = FeedbackMediaVO.toVO(feedbackMedia);
            String contentType = feedbackMedia.getMediaUrl().split("/")[4];
            if (contentType.equals("images")){
                dto.images.add(feedbackMediaVO);
            }
            else {
                dto.videos.add(feedbackMediaVO);
            }
        }

        return dto;

    }

}
