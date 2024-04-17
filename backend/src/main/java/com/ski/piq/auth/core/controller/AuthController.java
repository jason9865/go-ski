package com.ski.piq.auth.core.controller;

import com.ski.piq.auth.core.model.User;
import com.ski.piq.auth.core.service.AuthService;
import com.ski.piq.auth.support.dto.SigninResponseDTO;
import com.ski.piq.auth.support.dto.SignupRequestDTO;
import com.ski.piq.auth.support.exception.AuthExceptionEnum;
import com.ski.piq.auth.support.vo.Role;
import com.ski.piq.common.exception.ApiExceptionFactory;
import com.ski.piq.common.response.ApiResponse;
import com.ski.piq.oauth.type.OauthServerType;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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
            return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(signinResponseDTO));
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
        // role로 구분하면 엔드포인트 구분 필요 x
        // 사용자인경우 user 테이블만 입력, 강사인 경우 강사, 자격증 테이블도 입력

        MultipartFile profileImage = signupRequestDTO.getProfileImage();
        // 이미지 업로드하는 메소드 호출 후 서비스로 전달해줘야함

        authService.signup(domainUser, signupRequestDTO);

        Role role = signupRequestDTO.getRole();
        if ("INSTRUCTOR".equals(role.name())) {
            // instructor 테이블에 저장해야함
        }


        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    @GetMapping("/signout")
    ResponseEntity<ApiResponse<?>> logout(HttpServletRequest request) {
        authService.logout(request);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }
}