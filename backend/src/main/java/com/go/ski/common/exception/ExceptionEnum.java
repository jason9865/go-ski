package com.go.ski.common.exception;

import org.springframework.http.HttpStatus;

public interface ExceptionEnum {

    HttpStatus getStatus();
    int getCode();
    String getMessage();
}
