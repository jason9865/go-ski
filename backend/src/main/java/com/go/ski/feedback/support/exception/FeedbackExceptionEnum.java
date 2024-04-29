package com.go.ski.feedback.support.exception;


import com.go.ski.common.exception.ExceptionEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum FeedbackExceptionEnum implements ExceptionEnum {

    FEEDBACK_NOT_FOUND(HttpStatus.BAD_REQUEST,400,"해당 피드백이 존재하지 않습니다."),
    FEEDBACK_MEDIA_NOT_FOUND(HttpStatus.BAD_REQUEST,400,"해당 피드백이 존재하지 않습니다."),
    FEEDBACK_CREATE_FAIL(HttpStatus.INTERNAL_SERVER_ERROR,500,"피드백 작성에 실패했습니다."),
    FEEDBACK_UPDATE_FAIL(HttpStatus.INTERNAL_SERVER_ERROR,500,"피드백 수정에 실패했습니다.");

    private final HttpStatus status;
    private final int code;
    private final String message;

}
