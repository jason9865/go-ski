package com.go.ski.user.core.service;

import com.go.ski.auth.jwt.util.JwtUtil;
import com.go.ski.auth.oauth.client.OauthMemberClientComposite;
import com.go.ski.auth.oauth.type.OauthServerType;
import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.common.util.S3Uploader;
import com.go.ski.user.core.model.Certificate;
import com.go.ski.user.core.model.Instructor;
import com.go.ski.user.core.model.InstructorCert;
import com.go.ski.user.core.model.User;
import com.go.ski.user.core.repository.CertificateRepository;
import com.go.ski.user.core.repository.InstructorCertRepository;
import com.go.ski.user.core.repository.InstructorRepository;
import com.go.ski.user.core.repository.UserRepository;
import com.go.ski.user.support.dto.SignupRequestDTO;
import com.go.ski.user.support.exception.AuthExceptionEnum;
import com.go.ski.user.support.vo.CertificateVO;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.reactive.function.client.WebClientException;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class UserService {

    private final OauthMemberClientComposite oauthMemberClientComposite;
    private final UserRepository userRepository;
    private final InstructorRepository instructorRepository;
    private final InstructorCertRepository instructorCertRepository;
    private final CertificateRepository certificateRepository;
    private final JwtUtil jwtUtil;
    private final S3Uploader s3Uploader;

    public User login(OauthServerType oauthServerType, String role, String authCode, String accessToken) {
        try {
            User user = oauthMemberClientComposite.fetch(oauthServerType, role, authCode, accessToken);
            Optional<User> optionalUser = userRepository.findByDomain(user.getDomain());
            return optionalUser.orElse(user);
        } catch (WebClientException wce) {
            throw ApiExceptionFactory.fromExceptionEnum(AuthExceptionEnum.WRONG_CODE);
        }
    }

    public void createTokens(HttpServletResponse response, User user) {
        String accessToken = jwtUtil.createToken(user.getUserId(), user.getRole(), "access");
        String refreshToken = jwtUtil.createToken(user.getUserId(), user.getRole(), "refresh");
        jwtUtil.saveToken(refreshToken, accessToken);
        response.setHeader("accessToken", accessToken);
        response.setHeader("refreshToken", refreshToken);
    }

    @Transactional
    public User signupUser(User domainUser, SignupRequestDTO signupRequestDTO) {
        MultipartFile profileImage = signupRequestDTO.getProfileImage();
        if (profileImage != null && !profileImage.isEmpty()) {
            String profileUrl = s3Uploader.uploadFile("user-profile", profileImage);
            domainUser.setProfileUrl(profileUrl);
            log.info("profileUrl: {}", profileUrl);
        }

        User user = User.builder()
                .domain(domainUser.getDomain())
                .userName(signupRequestDTO.getUserName())
                .birthDate(signupRequestDTO.getBirthDate())
                .phoneNumber(signupRequestDTO.getPhoneNumber())
                .gender(signupRequestDTO.getGender())
                .role(signupRequestDTO.getRole())
                .profileUrl(domainUser.getProfileUrl())
                .build();
        user = userRepository.save(user);

        if ("INSTRUCTOR".equals(user.getRole().name())) {
            Instructor instructor = Instructor.builder()
                    .userId(user.getUserId())
                    .user(user)
                    .build();
            instructorRepository.save(instructor);

            // 강사인 경우 자격증도 db에 입력해야함
            List<CertificateVO> certificateVOs = signupRequestDTO.getCertificateVOs();
            if (certificateVOs != null && !certificateVOs.isEmpty()) {
                for (CertificateVO certificateVO : certificateVOs) {
                    log.info("{}", certificateVO);

                    Optional<Certificate> optionalCertificate = certificateRepository.findById(certificateVO.getCertificateId());
                    if (optionalCertificate.isPresent()) {
                        String certificateImageUrl = s3Uploader.uploadFile("certificate/" + user.getUserId(), certificateVO.getCertificateImage());
                        log.info("certificateImageUrl: {}", certificateImageUrl);

                        InstructorCert instructorCert = InstructorCert.builder()
                                .certificate(optionalCertificate.get())
                                .instructor(instructor)
                                .certificateImageUrl(certificateImageUrl)
                                .build();
                        instructorCertRepository.save(instructorCert);
                    }
                }
            }
        }

        return user;
    }

    public void logout(HttpServletResponse response) {
        String refreshToken = response.getHeader("refreshToken");
        log.info("리프레시 토큰: {}", refreshToken);
        jwtUtil.deleteToken(refreshToken);
        response.setHeader("accessToken", null);
        response.setHeader("refreshToken", null);
    }
}