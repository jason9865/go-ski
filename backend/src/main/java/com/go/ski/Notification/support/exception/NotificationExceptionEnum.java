package com.go.ski.Notification.support.exception;

import com.go.ski.common.exception.ExceptionEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum NotificationExceptionEnum implements ExceptionEnum {

    NOTIFICATION_NOT_FOUND(HttpStatus.BAD_REQUEST,400,"해당 알림이 존재하지 않습니다!");

    private final HttpStatus status;
    private final int code;
    private final String message;

}
