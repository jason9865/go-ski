package com.ski.piq.auth.core.service;

import com.ski.piq.auth.core.model.User;
import com.ski.piq.auth.core.repository.UserRepository;
import com.ski.piq.auth.support.dto.SignupRequestDTO;
import com.ski.piq.auth.support.exception.AuthExceptionEnum;
import com.ski.piq.common.exception.ApiExceptionFactory;
import com.ski.piq.oauth.client.OauthMemberClientComposite;
import com.ski.piq.oauth.type.OauthServerType;
import jakarta.servlet.http.HttpServletRequest;
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
public class AuthService {

    private final OauthMemberClientComposite oauthMemberClientComposite;
    private final UserRepository userRepository;

    public User login(OauthServerType oauthServerType, String authCode, String accessToken) {
        try {
            User user = oauthMemberClientComposite.fetch(oauthServerType, authCode, accessToken);
            Optional<User> optionalUser = userRepository.findByDomain(user.getDomain());
            return optionalUser.orElse(user);
        } catch (WebClientException wce) {
            throw ApiExceptionFactory.fromExceptionEnum(AuthExceptionEnum.WRONG_CODE);
        }
    }

    public void signup(User domainUser, SignupRequestDTO signupRequestDTO) {
        User user = User.builder()
                .domain(domainUser.getDomain())
                .name(signupRequestDTO.getName())
                .birthDate(signupRequestDTO.getBirthDate())
                .phoneNumber(signupRequestDTO.getPhoneNumber())
                .gender(signupRequestDTO.getGender())
                .role(signupRequestDTO.getRole())
//                .profileUrl()
                .build();
        userRepository.save(user);

        if ("INSTRUCTOR".equals(user.getRole().name())) {

        }
    }

    public void logout(HttpServletRequest request) {
        log.info("유저 로그아웃");
    }
}