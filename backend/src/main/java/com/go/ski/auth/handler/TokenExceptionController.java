package com.go.ski.auth.handler;

import com.go.ski.auth.exception.AuthExceptionEnum;
import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.user.support.exception.UserExceptionEnum;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("/api/v1/exception")
public class TokenExceptionController {

    @GetMapping("/entrypoint")
    public void entryPoint() {
        throw ApiExceptionFactory.fromExceptionEnum(UserExceptionEnum.NO_LOGIN);
    }

    @GetMapping("/accessDenied")
    public void denied() {
        throw ApiExceptionFactory.fromExceptionEnum(AuthExceptionEnum.NO_ADMIN);
    }
}