package com.go.ski.user.core.controller;

import com.go.ski.auth.oauth.type.OauthServerType;
import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.common.response.ApiResponse;
import com.go.ski.user.core.model.User;
import com.go.ski.user.core.service.UserService;
import com.go.ski.user.support.dto.SigninRequestDTO;
import com.go.ski.user.support.dto.SignupRequestDTO;
import com.go.ski.user.support.exception.AuthExceptionEnum;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1/user")
@RestController
public class UserController {
    private final UserService userService;

    @PostMapping("/signin/{oauthServerType}")
    public ResponseEntity<ApiResponse<?>> loginStudent(
            HttpServletRequest request,
            HttpServletResponse response,
            @PathVariable OauthServerType oauthServerType,
            @RequestBody SigninRequestDTO signinRequestDto) {
        log.info("{} 로그인 요청, code: {}, token: {}", signinRequestDto.getRole(), signinRequestDto.getCode(), signinRequestDto.getToken());

        User user = userService.login(oauthServerType, signinRequestDto.getRole(), signinRequestDto.getCode(), signinRequestDto.getToken());

        if (user.getUserId() == 0) {
            log.info("회원가입 필요");
            HttpSession session = request.getSession(); // session에 도메인 정보 넣어두고 회원가입 요청에서 사용
            session.setAttribute("user", user);
        } else {
            log.info("로그인 성공");
            userService.createTokens(response, user);
        }

        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    @PostMapping("/signup/student")
    public ResponseEntity<ApiResponse<?>> signupStudent(HttpServletRequest request, HttpServletResponse response, @ModelAttribute SignupRequestDTO signupRequestDTO) {
        log.info("교육생 회원가입 요청: {}", signupRequestDTO);
        if (!"STUDENT".equals(signupRequestDTO.getRole().toString())) {
            throw ApiExceptionFactory.fromExceptionEnum(AuthExceptionEnum.WRONG_REQUEST);
        }

        signup(request, response, signupRequestDTO);

        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    @PostMapping("/signup/inst")
    public ResponseEntity<ApiResponse<?>> signupInstructor(HttpServletRequest request, HttpServletResponse response, @ModelAttribute SignupRequestDTO signupRequestDTO) {
        log.info("강사 회원가입 요청: {}", signupRequestDTO);
        if (!"INSTRUCTOR".equals(signupRequestDTO.getRole().toString()) && !"OWNER".equals(signupRequestDTO.getRole().toString())) {
            throw ApiExceptionFactory.fromExceptionEnum(AuthExceptionEnum.WRONG_REQUEST);
        }

        signup(request, response, signupRequestDTO);

        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    private void signup(HttpServletRequest request, HttpServletResponse response, SignupRequestDTO signupRequestDTO) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            throw ApiExceptionFactory.fromExceptionEnum(AuthExceptionEnum.NO_LOGIN);
        }

        User domainUser = (User) session.getAttribute("user"); // 도메인만 있는 유저 객체
        User user = userService.signupUser(domainUser, signupRequestDTO);

        log.info("회원가입 성공");
        userService.createTokens(response, user);
    }

    @GetMapping("/signout")
    public ResponseEntity<ApiResponse<?>> logout(HttpServletResponse response) {
        log.info("유저 로그아웃");
        userService.logout(response);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }
}