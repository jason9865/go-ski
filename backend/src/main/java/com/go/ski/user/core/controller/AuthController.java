package com.go.ski.user.core.controller;

import com.go.ski.user.core.model.User;
import com.go.ski.user.core.service.AuthService;
import com.go.ski.user.support.dto.SigninResponseDTO;
import com.go.ski.user.support.dto.SignupRequestDTO;
import com.go.ski.user.support.exception.AuthExceptionEnum;
import com.go.ski.user.support.vo.Certificate;
import com.go.ski.user.support.vo.Role;
import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.common.response.ApiResponse;
import com.go.ski.auth.oauth.type.OauthServerType;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;


@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1/auth")
@RestController
public class AuthController {

    private final AuthService authService;

    @PostMapping("/signin/{oauthServerType}")
    ResponseEntity<ApiResponse<?>> login(
            HttpServletRequest request,
            @PathVariable OauthServerType oauthServerType,
            @RequestBody Map<String, String> params) {
        String code = params.get("code");
        String token = params.get("token");
        log.info("로그인 요청, code: {}, token: {}", code, token);

        User user = authService.login(oauthServerType, code, token);
        HttpSession session = request.getSession();
        session.setAttribute("user", user);

        if (user.getUserId() == 0) {
            log.info("회원가입 필요");
            return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
        } else {
            log.info("로그인 성공");
            // JWT refresh token 만들어야함
            SigninResponseDTO signinResponseDTO = new SigninResponseDTO(user);
            return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
        }
    }

    @PostMapping("/signup")
    ResponseEntity<ApiResponse<?>> signup(HttpServletRequest request, @ModelAttribute SignupRequestDTO signupRequestDTO) {
        log.info("회원가입 요청");
        HttpSession session = request.getSession(false);
        if (session == null) {
            throw ApiExceptionFactory.fromExceptionEnum(AuthExceptionEnum.NO_LOGIN);
        }
        User domainUser = (User) session.getAttribute("user"); // 도메인만 있는 유저 객체

        MultipartFile profileImage = signupRequestDTO.getProfileImage();
        // 이미지 업로드하는 메소드 호출 후 서비스로 전달해줘야함

        authService.signup(domainUser, signupRequestDTO);

        // 강사인 경우 자격증도 dp에 입력해야함
        Role role = signupRequestDTO.getRole();
        if ("INSTRUCTOR".equals(role.name())) {
            List<Certificate> certificates = signupRequestDTO.getCertificates();
        }


        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    @GetMapping("/signout")
    ResponseEntity<ApiResponse<?>> logout(HttpServletRequest request) {
        authService.logout(request);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }
}