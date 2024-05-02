package com.go.ski.notification.support.exception;

import com.go.ski.common.exception.ExceptionEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum NotificationExceptionEnum implements ExceptionEnum {

    NOTIFICATION_NOT_FOUND(HttpStatus.BAD_REQUEST,400,"해당 알림이 존재하지 않습니다."),
    GOOGLE_REQUEST_TOKEN_ERROR(HttpStatus.INTERNAL_SERVER_ERROR,500,"구글에 토큰 요청하는 과정에서 에러가 발생했습니다."),
    CONVERTING_JSON_ERROR(HttpStatus.INTERNAL_SERVER_ERROR,500,"알림 메시지를 JSON으로 변환하는 과정에서 에러가 발생했습니다."),
    FIREBASE_CONNECTION_ERROR(HttpStatus.INTERNAL_SERVER_ERROR,500,"Firebase와 통신하는 과정에서 에러가 발생했습니다.");

    private final HttpStatus status;
    private final int code;
    private final String message;

}
