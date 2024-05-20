package com.go.ski.common.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public class ApiException extends RuntimeException {
    private final HttpStatus status;
    private final int code;
    private final String message;

    public ApiException(HttpStatus status, int code, String message) {
        super(message);
        this.status = status;
        this.code = code;
        this.message = message;
    }


    public ApiException(ApiException e) {
        this.status = e.getStatus();
        this.code = e.getCode();
        this.message = e.getMessage();
    }
}