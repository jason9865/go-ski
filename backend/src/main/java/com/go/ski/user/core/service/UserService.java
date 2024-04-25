package com.go.ski.user.core.service;

import com.go.ski.auth.exception.AuthExceptionEnum;
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
import com.go.ski.user.support.dto.*;
import com.go.ski.user.support.vo.CertificateImageVO;
import com.go.ski.user.support.vo.CertificateUrlVO;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.reactive.function.client.WebClientException;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Slf4j
@Service
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
            return userRepository.findByDomain(user.getDomain()).orElse(user);
        } catch (WebClientException wce) {
            throw ApiExceptionFactory.fromExceptionEnum(AuthExceptionEnum.WRONG_CODE);
        }
    }

    public User signupUser(User domainUser, SignupUserRequestDTO signupUserRequestDTO) {
        User user = User.builder()
                .domain(domainUser.getDomain())
                .userName(signupUserRequestDTO.getUserName())
                .birthDate(signupUserRequestDTO.getBirthDate())
                .phoneNumber(signupUserRequestDTO.getPhoneNumber())
                .gender(signupUserRequestDTO.getGender())
                .role(signupUserRequestDTO.getRole())
                .profileUrl(domainUser.getProfileUrl())
                .build();

        // 프로필 이미지 업로드 후 save
        uploadProfileImage(user, signupUserRequestDTO);
        return user;
    }

    @Transactional
    public User signupInstructor(User domainUser, SignupInstructorRequestDTO signupInstructorRequestDTO) {
        User user = User.builder()
                .domain(domainUser.getDomain())
                .userName(signupInstructorRequestDTO.getUserName())
                .birthDate(signupInstructorRequestDTO.getBirthDate())
                .phoneNumber(signupInstructorRequestDTO.getPhoneNumber())
                .gender(signupInstructorRequestDTO.getGender())
                .role(signupInstructorRequestDTO.getRole())
                .profileUrl(domainUser.getProfileUrl())
                .build();

        // 프로필 이미지 업로드 후 save
        uploadProfileImage(user, signupInstructorRequestDTO);

        Instructor instructor = Instructor.builder()
                .instructorId(user.getUserId())
                .user(user)
                .build();
        instructorRepository.save(instructor);

        // 자격증 사진 업로드 후 save
        uploadCertificateImages(instructor, signupInstructorRequestDTO);
        return user;
    }

    public void logout(HttpServletResponse response) {
        String refreshToken = response.getHeader("refreshToken");
        jwtUtil.deleteToken(refreshToken);
        response.setHeader("accessToken", null);
        response.setHeader("refreshToken", null);
    }

    public void updateUser(User user, ProfileImageDTO profileImageDTO) {
        uploadProfileImage(user, profileImageDTO);
    }

    @Transactional
    public void updateInstructor(User user, UpdateInstructorRequestDTO updateInstructorRequestDTO) {
        uploadProfileImage(user, updateInstructorRequestDTO);

        Instructor instructor = instructorRepository.findById(user.getUserId()).orElseThrow();
        instructor.setDescription(updateInstructorRequestDTO.getDescription());
        instructor.setDayoff(updateInstructorRequestDTO.getDayoff());
        instructor.setIsInstructAvailable(updateInstructorRequestDTO.getIsInstructAvailable());
        instructorRepository.save(instructor);

        uploadCertificateImages(instructor, updateInstructorRequestDTO);
    }

    public void resign(User user) {
        user.setExpiredDate(LocalDateTime.now());
        userRepository.save(user);
    }

    public ProfileUserResponseDTO getUser(User user) {
        return ProfileUserResponseDTO.builder()
                .userName(user.getUserName())
                .profileUrl(user.getProfileUrl())
                .phoneNumber(user.getPhoneNumber())
                .role(user.getRole())
                .birthDate(user.getBirthDate())
                .gender(user.getGender())
                .build();
    }

    public ProfileInstructorResponseDTO getInstructor(User user, ProfileUserResponseDTO profileUserResponseDTO) {
        Instructor instructor = Instructor.builder().instructorId(user.getUserId()).build();
        List<InstructorCert> instructorCerts = instructorCertRepository.findByInstructor(instructor);

        List<CertificateUrlVO> certificateUrlVOs = new ArrayList<>();
        for (InstructorCert instructorCert : instructorCerts) {
            certificateUrlVOs.add(CertificateUrlVO.builder()
                    .certificateId(instructorCert.getCertificate().getCertificateId())
                    .certificateImageUrl(instructorCert.getCertificateImageUrl())
                    .build());
        }
        return new ProfileInstructorResponseDTO(profileUserResponseDTO, certificateUrlVOs);
    }

    public void createTokens(HttpServletResponse response, User user) {
        String accessToken = jwtUtil.createToken(user.getUserId(), user.getRole(), "access");
        String refreshToken = jwtUtil.createToken(user.getUserId(), user.getRole(), "refresh");
        jwtUtil.saveToken(refreshToken, accessToken);
        response.setHeader("accessToken", accessToken);
        response.setHeader("refreshToken", refreshToken);
    }

    private void uploadProfileImage(User user, ProfileImageDTO profileImageDTO) {
        MultipartFile profileImage = profileImageDTO.getProfileImage();
        if (profileImage != null && !profileImage.isEmpty()) {
            String profileUrl = s3Uploader.uploadFile("user-profile", profileImage);
            log.info("profileUrl: {}", profileUrl);

            user.setProfileUrl(profileUrl);
            userRepository.save(user);
        }
    }

    private void uploadCertificateImages(Instructor instructor, InstructorImagesDTO instructorImagesDTO) {
        instructorCertRepository.deleteByInstructor(instructor);

        List<CertificateImageVO> certificateImageVOs = instructorImagesDTO.getCertificateImageVOs();
        if (certificateImageVOs != null && !certificateImageVOs.isEmpty()) {
            for (CertificateImageVO certificateImageVO : certificateImageVOs) {
                log.info("{}", certificateImageVO);

                Optional<Certificate> optionalCertificate = certificateRepository.findById(certificateImageVO.getCertificateId());
                if (optionalCertificate.isPresent()) {
                    String certificateImageUrl = s3Uploader.uploadFile("certificate/" + instructor.getInstructorId(), certificateImageVO.getCertificateImage());
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
}