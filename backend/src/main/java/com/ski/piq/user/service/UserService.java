package com.ski.piq.user.service;

import com.ski.piq.common.exception.ApiExceptionFactory;
import com.ski.piq.oauth.client.OauthMemberClientComposite;
import com.ski.piq.oauth.type.OauthServerType;
import com.ski.piq.user.exception.UserExceptionEnum;
import com.ski.piq.user.model.LoginLog;
import com.ski.piq.user.model.User;
import com.ski.piq.user.repository.LoginLogRepository;
import com.ski.piq.user.repository.UserRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.reactive.function.client.WebClientException;

import java.util.Optional;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class UserService {

    private final OauthMemberClientComposite oauthMemberClientComposite;
    private final UserRepository userRepository;
    private final LoginLogRepository loginLogRepository;

    public void login(HttpServletRequest request, HttpServletResponse response, OauthServerType oauthServerType, String authCode) {
        try {
            User user = oauthMemberClientComposite.fetch(oauthServerType, authCode);
            User saved;
            Optional<User> optionalUser = userRepository.findByDomain(user.getDomain());
            if (optionalUser.isEmpty()) {
                saved = userRepository.save(user);
            } else {
                saved = userRepository.findByDomain(user.getDomain()).get();
            }

            LoginLog loginLog = LoginLog.builder().userId(saved.getUserId()).loginIp(getClientIP(request)).build();
            loginLogRepository.save(loginLog);

            log.info("{} 유저 로그인", saved.getUserId());
        } catch (WebClientException wce) {
            log.error(wce.getMessage());
            throw ApiExceptionFactory.fromExceptionEnum(UserExceptionEnum.WRONG_CODE);
        }
    }

    public void logout(HttpServletRequest request) {
        log.info("유저 로그아웃");
    }

    private static String getClientIP(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        log.info("> X-FORWARDED-FOR : " + ip);

        if (ip == null) {
            ip = request.getHeader("Proxy-Client-IP");
            log.info("> Proxy-Client-IP : " + ip);
        }
        if (ip == null) {
            ip = request.getHeader("WL-Proxy-Client-IP");
            log.info(">  WL-Proxy-Client-IP : " + ip);
        }
        if (ip == null) {
            ip = request.getHeader("HTTP_CLIENT_IP");
            log.info("> HTTP_CLIENT_IP : " + ip);
        }
        if (ip == null) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
            log.info("> HTTP_X_FORWARDED_FOR : " + ip);
        }
        if (ip == null) {
            ip = request.getRemoteAddr();
            log.info("> getRemoteAddr : " + ip);
        }
        log.info("> Result : IP Address : " + ip);

        return ip;
    }
}