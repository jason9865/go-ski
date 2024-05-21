package com.go.ski.common.exception;


import com.go.ski.common.response.ApiResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataAccessException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.reactive.resource.NoResourceFoundException;

import java.sql.SQLException;
import java.util.NoSuchElementException;


@Slf4j
@RestControllerAdvice
public class ApiExceptionAdvice {

    @ExceptionHandler(ApiException.class)
    @ResponseStatus
    public ResponseEntity<ApiResponse<?>> handleApiException(ApiException e) {
        log.error("ApiException 에러 메시지: {}", e.getMessage());
        return ResponseEntity
                .status(e.getStatus())
                .body(ApiResponse.error(e.getMessage()));
    }

    @ExceptionHandler(NoSuchElementException.class)
    @ResponseStatus
    public ResponseEntity<ApiResponse<?>> handleNoSuchElementException(NoSuchElementException e) {
        log.error("NoSuchElementException 에러 메시지: {}", e.getMessage());
        return ResponseEntity
                .status(CommonExceptionEnum.NO_SUCH_ELEMENT.getStatus())
                .body(ApiResponse.error(CommonExceptionEnum.NO_SUCH_ELEMENT.getMessage()));
    }

    @ExceptionHandler(DataAccessException.class)
    @ResponseStatus
    public ResponseEntity<ApiResponse<?>> handleDataException(DataAccessException e) {
        log.error("DataAccessException 에러 메시지: {}", e.getMessage());
        return ResponseEntity
                .status(CommonExceptionEnum.DATA_ACCESS_ERROR.getStatus())
                .body(ApiResponse.error(CommonExceptionEnum.DATA_ACCESS_ERROR.getMessage()));
    }

    @ExceptionHandler(SQLException.class)
    @ResponseStatus
    public ResponseEntity<ApiResponse<?>> handleSQLException(SQLException e) {
        log.error("SQLException 에러 메시지: {}", e.getMessage());
        return ResponseEntity
                .status(CommonExceptionEnum.DATA_ACCESS_ERROR.getStatus())
                .body(ApiResponse.error(CommonExceptionEnum.DATA_ACCESS_ERROR.getMessage()));
    }


    @ExceptionHandler(NoResourceFoundException.class)
    @ResponseStatus
    public ResponseEntity<ApiResponse<?>> handleNoResourceFoundException(NoResourceFoundException e) {
        log.error("NoResourceFoundException 에러 메시지: {}", e.getMessage());
        return ResponseEntity
                .status(CommonExceptionEnum.NO_STATIC_RESOURCE.getStatus())
                .body(ApiResponse.error(CommonExceptionEnum.NO_STATIC_RESOURCE.getMessage()));
    }

    @ExceptionHandler(Exception.class)
    @ResponseStatus
    public ResponseEntity<ApiResponse<?>> handleException(Exception e) {
        log.error("Exception 에러 메시지: {}, {}", e, e.getMessage());
        return ResponseEntity
                .status(CommonExceptionEnum.UNKNOWN_ERROR.getStatus())
                .body(ApiResponse.error(CommonExceptionEnum.UNKNOWN_ERROR.getMessage()));
    }
}