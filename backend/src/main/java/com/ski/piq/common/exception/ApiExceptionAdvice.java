package com.ski.piq.common.exception;


import com.ski.piq.common.response.ApiResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataAccessException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.sql.SQLException;

import static com.ski.piq.common.exception.CommonExceptionEnum.DATA_ACCESS_ERROR;
import static com.ski.piq.common.exception.CommonExceptionEnum.UNKNOWN_ERROR;


@Slf4j
@RestControllerAdvice
public class ApiExceptionAdvice {

    @ExceptionHandler(ApiException.class)
    @ResponseStatus
    public ResponseEntity<ApiResponse<?>> handleApiException(ApiException e) {
        log.error("에러 메시지: {}", e.getMessage());
        return ResponseEntity
                .status(e.getStatus())
                .body(ApiResponse.error(e.getMessage()));
    }

    @ExceptionHandler(DataAccessException.class)
    @ResponseStatus
    public ResponseEntity<ApiResponse<?>> handleDataException(DataAccessException e) {
        log.error("에러 메시지: {}", e.getMessage());
        return ResponseEntity
                .status(DATA_ACCESS_ERROR.getStatus())
                .body(ApiResponse.error(DATA_ACCESS_ERROR.getMessage()));
    }

    @ExceptionHandler(SQLException.class)
    @ResponseStatus
    public ResponseEntity<ApiResponse<?>> handleSQLException(SQLException e) {
        log.error("에러 메시지: {}", e.getMessage());
        return ResponseEntity
                .status(DATA_ACCESS_ERROR.getStatus())
                .body(ApiResponse.error(DATA_ACCESS_ERROR.getMessage()));
    }

    @ExceptionHandler(Exception.class)
    @ResponseStatus
    public ResponseEntity<ApiResponse<?>> handleException(Exception e) {
        log.error("에러 메시지: {}", e.getMessage());
        return ResponseEntity
                .status(UNKNOWN_ERROR.getStatus())
                .body(ApiResponse.error(UNKNOWN_ERROR.getMessage()));
    }
}