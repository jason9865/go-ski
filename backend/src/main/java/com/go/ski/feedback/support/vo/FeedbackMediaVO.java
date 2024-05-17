package com.go.ski.feedback.support.vo;

import com.go.ski.feedback.core.model.FeedbackMedia;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class FeedbackMediaVO {

    private Integer mediaId;
    private String mediaUrl;

    public static FeedbackMediaVO toVO(FeedbackMedia feedbackMedia) {
        FeedbackMediaVO vo = new FeedbackMediaVO();
        vo.mediaId = feedbackMedia.getFeedbackMediaId();
        vo.mediaUrl = feedbackMedia.getMediaUrl();
        return vo;
    }

}
