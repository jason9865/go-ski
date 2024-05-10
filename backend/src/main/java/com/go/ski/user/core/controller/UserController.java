package com.go.ski.user.core.controller;

import com.go.ski.auth.oauth.type.OauthServerType;
import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.common.response.ApiResponse;
import com.go.ski.user.core.model.User;
import com.go.ski.user.core.service.UserService;
import com.go.ski.user.support.dto.*;
import com.go.ski.user.support.exception.UserExceptionEnum;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.mutable.Mutable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;


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

        if (user.getUserId() == null) {
            log.info("회원가입 필요");
        } else {
            if (user.getExpiredDate() != null) {
                log.info("탈퇴한 유저: {}", user.getExpiredDate());
                throw ApiExceptionFactory.fromExceptionEnum(UserExceptionEnum.RESIGNED_USER);
            }
            log.info("로그인 성공");
            userService.createTokens(response, user);
        }
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    @PostMapping("/signup/user")
    public ResponseEntity<ApiResponse<?>> signupStudent(HttpServletResponse response, @ModelAttribute SignupUserRequestDTO signupUserRequestDTO) {
        log.info("교육생 회원가입 요청: {}", signupUserRequestDTO);
        if (!"STUDENT".equals(signupUserRequestDTO.getRole().toString()) && !"OWNER".equals(signupUserRequestDTO.getRole().toString())) {
            throw ApiExceptionFactory.fromExceptionEnum(UserExceptionEnum.WRONG_REQUEST);
        }

        User user = userService.signupUser(signupUserRequestDTO);

        log.info("회원가입 성공");
        userService.createTokens(response, user);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    @PostMapping("/signup/inst")
    public ResponseEntity<ApiResponse<?>> signupInstructor(HttpServletResponse response,
                                                           @ModelAttribute SignupInstructorRequestDTO signupInstructorRequestDTO,
                                                           @RequestPart MultipartFile profileImage) {
        log.info("강사 회원가입 요청: {}", signupInstructorRequestDTO);
        if (!"INSTRUCTOR".equals(signupInstructorRequestDTO.getRole().toString())) {
            throw ApiExceptionFactory.fromExceptionEnum(UserExceptionEnum.WRONG_REQUEST);
        }

        User user = userService.signupInstructor(signupInstructorRequestDTO, profileImage);

        log.info("회원가입 성공");
        userService.createTokens(response, user);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    @GetMapping("/signout")
    public ResponseEntity<ApiResponse<?>> logout(HttpServletResponse response) {
        log.info("유저 로그아웃");
        userService.logout(response);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    @PatchMapping("/update/user")
    public ResponseEntity<ApiResponse<?>> updateUser(HttpServletRequest request, @ModelAttribute ProfileImageDTO profileImageDTO) {
        log.info("교육생, 사장 업데이트 요청: {}", profileImageDTO);
        if (profileImageDTO == null) {
            throw ApiExceptionFactory.fromExceptionEnum(UserExceptionEnum.NO_PARAM);
        }
        User user = (User) request.getAttribute("user");
        userService.updateUser(user, profileImageDTO);

        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    @PatchMapping("/update/inst")
    public ResponseEntity<ApiResponse<?>> updateInstructor(HttpServletRequest request, @ModelAttribute UpdateInstructorRequestDTO updateInstructorRequestDTO) {
        log.info("강사 업데이트 요청: {}", updateInstructorRequestDTO);
        if (updateInstructorRequestDTO == null) {
            throw ApiExceptionFactory.fromExceptionEnum(UserExceptionEnum.NO_PARAM);
        }
        User user = (User) request.getAttribute("user");
        userService.updateInstructor(user, updateInstructorRequestDTO);

        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    @DeleteMapping("/resign")
    public ResponseEntity<ApiResponse<?>> deleteUser(HttpServletRequest request, HttpServletResponse response) {
        log.info("유저 회원탈퇴");
        User user = (User) request.getAttribute("user");
        userService.resign(user);
        userService.logout(response);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    @GetMapping("/profile/user")
    public ResponseEntity<ApiResponse<?>> getUser(HttpServletRequest request) {
        log.info("교육생, 사장 프로필 요청");
        User user = (User) request.getAttribute("user");
        ProfileUserResponseDTO profileUserResponseDTO = userService.getUser(user);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(profileUserResponseDTO));
    }

    @GetMapping("/profile/inst")
    public ResponseEntity<ApiResponse<?>> getInstructor(HttpServletRequest request) {
        log.info("강사 프로필 요청");
        User user = (User) request.getAttribute("user");
        ProfileUserResponseDTO profileUserResponseDTO = userService.getUser(user);
        ProfileInstructorResponseDTO profileInstructorResponseDTO = userService.getInstructor(user, profileUserResponseDTO);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(profileInstructorResponseDTO));
    }

    @GetMapping("/profile/inst/{instructorId}")
    public ResponseEntity<ApiResponse<?>> getInstructorById(@PathVariable Integer instructorId) {
        log.info("강사 Id를 통해 강사 프로필 조회");
        ProfileInstructorResponseDTO profileInstructorResponseDTO = userService.getInstructorById(instructorId);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(profileInstructorResponseDTO));
    }
}