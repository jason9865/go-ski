package com.go.ski.user.core.service;

import com.go.ski.auth.exception.AuthExceptionEnum;
import com.go.ski.auth.jwt.util.JwtUtil;
import com.go.ski.auth.oauth.client.OauthMemberClientComposite;
import com.go.ski.auth.oauth.dto.Domain;
import com.go.ski.auth.oauth.type.OauthServerType;
import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.common.util.S3Uploader;
import com.go.ski.notification.core.repository.NotificationSettingRepository;
import com.go.ski.notification.core.repository.NotificationTypeRepository;
import com.go.ski.notification.support.generators.NotificationSettingGenerator;
import com.go.ski.user.core.model.Certificate;
import com.go.ski.user.core.model.Instructor;
import com.go.ski.user.core.model.InstructorCert;
import com.go.ski.user.core.model.User;
import com.go.ski.user.core.repository.CertificateRepository;
import com.go.ski.user.core.repository.InstructorCertRepository;
import com.go.ski.user.core.repository.InstructorRepository;
import com.go.ski.user.core.repository.UserRepository;
import com.go.ski.user.support.dto.*;
import com.go.ski.user.support.exception.UserExceptionEnum;
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
    private final NotificationSettingGenerator generator;

    public User login(OauthServerType oauthServerType, String role, String authCode, String accessToken) {
        try {
            User user = oauthMemberClientComposite.fetch(oauthServerType, role, authCode, accessToken);
            return userRepository.findByDomain(user.getDomain()).orElse(user);
        } catch (WebClientException wce) {
            throw ApiExceptionFactory.fromExceptionEnum(AuthExceptionEnum.WRONG_CODE);
        }
    }

    public User signupUser(SignupUserRequestDTO signupUserRequestDTO) {
        User user=  User.builder()
                .domain(new Domain(signupUserRequestDTO.getDomainUserKey(), OauthServerType.kakao))
                .userName(signupUserRequestDTO.getUserName())
                .birthDate(signupUserRequestDTO.getBirthDate())
                .phoneNumber(signupUserRequestDTO.getPhoneNumber())
                .gender(signupUserRequestDTO.getGender())
                .role(signupUserRequestDTO.getRole())
                .profileUrl(signupUserRequestDTO.getProfileUrl())
                .build();

        // 프로필 이미지 업로드 후 save
        uploadProfileImage(user, signupUserRequestDTO);

        // 알림 권한 종류 추가
        generator.createNotificationSettings(user);

        return user;
    }

    @Transactional
    public User signupInstructor(SignupInstructorRequestDTO signupInstructorRequestDTO) {
        User user = User.builder()
                .domain(new Domain(signupInstructorRequestDTO.getDomainUserKey(), OauthServerType.kakao))
                .userName(signupInstructorRequestDTO.getUserName())
                .birthDate(signupInstructorRequestDTO.getBirthDate())
                .phoneNumber(signupInstructorRequestDTO.getPhoneNumber())
                .gender(signupInstructorRequestDTO.getGender())
                .role(signupInstructorRequestDTO.getRole())
                .profileUrl(signupInstructorRequestDTO.getKakaoProfileUrl())
                .build();

        // 프로필 이미지 업로드 후 save
        uploadProfileImage(user, signupInstructorRequestDTO);

        Instructor instructor = new Instructor(user, signupInstructorRequestDTO.getLessonType());
        instructorRepository.save(instructor);

        // 자격증 사진 업로드 후 save
        uploadCertificateImages(instructor, signupInstructorRequestDTO);

        // 알림 권한 종류 추가
        generator.createNotificationSettings(user);

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
        int binaryLevel = Integer.parseInt(instructor.getIsInstructAvailable(), 2) & 79;
        switch (updateInstructorRequestDTO.getLessonType()) {
            case "ALL" -> instructor.setIsInstructAvailable(String.valueOf(0b1110000 | binaryLevel));
            case "SKI" -> instructor.setIsInstructAvailable(String.valueOf(0b1010000 | binaryLevel));
            case "BOARD" -> instructor.setIsInstructAvailable(String.valueOf(0b1100000 | binaryLevel));
        }
        instructorRepository.save(instructor);

        deleteCertificateImages(instructor, updateInstructorRequestDTO.getDeleteCertificateUrls());
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

    public ProfileInstructorResponseDTO getInstructorById(Integer instructorId) {
        User user = userRepository.findById(instructorId)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(UserExceptionEnum.USER_NOT_FOUND));

        ProfileUserResponseDTO profileUserResponseDTO = getUser(user);

        Instructor instructor = instructorRepository.findById(instructorId)
                        .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(UserExceptionEnum.INSTRUCTOR_NOT_FOUND));
        log.info(instructor.getDescription());
        List<InstructorCert> instructorCerts = instructorCertRepository.findByInstructor(instructor);

        List<CertificateUrlVO> certificateUrlVOs = new ArrayList<>();
        for (InstructorCert instructorCert : instructorCerts) {
            certificateUrlVOs.add(CertificateUrlVO.builder()
                    .certificateId(instructorCert.getCertificate().getCertificateId())
                    .certificateImageUrl(instructorCert.getCertificateImageUrl())
                    .build());
        }

        return new ProfileInstructorResponseDTO(profileUserResponseDTO,certificateUrlVOs,instructor);
    }


    public void createTokens(HttpServletResponse response, User user) {
        String accessToken = jwtUtil.createToken(user.getUserId(), user.getRole(), "access");
        String refreshToken = jwtUtil.createToken(user.getUserId(), user.getRole(), "refresh");
        jwtUtil.saveToken(refreshToken, accessToken);
        response.setHeader("accessToken", accessToken);
        response.setHeader("refreshToken", refreshToken);
    }

    private void uploadProfileImage(User user, ProfileImageDTO profileImageDTO) {
        log.info("instructor profileImage - {}", profileImageDTO.getProfileImage().getOriginalFilename());
        MultipartFile profileImage = profileImageDTO.getProfileImage();
        if (profileImage != null && !profileImage.isEmpty()) {
            if (user.getProfileUrl() != null) {
                s3Uploader.deleteFile(user.getProfileUrl());
            }
            String profileUrl = s3Uploader.uploadFile("user-profile", profileImage);
            log.info("profileUrl: {}", profileUrl);

            user.setProfileUrl(profileUrl);
        }
        userRepository.save(user);
    }

    private void uploadCertificateImages(Instructor instructor, InstructorImagesDTO instructorImagesDTO) {
        List<CertificateImageVO> certificateImageVOs = instructorImagesDTO.getCertificateImageVOs();
        log.info("instructor Certificates size - {}", instructorImagesDTO.getCertificateImageVOs().size());
        if (certificateImageVOs != null && !certificateImageVOs.isEmpty()) {
            for (CertificateImageVO certificateImageVO : certificateImageVOs) {
                log.info("certificateID - {}",certificateImageVO.getCertificateId());
                log.info("certificateID - {}",certificateImageVO.getCertificateImage().getOriginalFilename());
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

                    int binaryLevel = Integer.parseInt(instructor.getIsInstructAvailable(), 2);
                    binaryLevel |= convertIdToBinary(certificateImageVO.getCertificateId());
                    instructor.setIsInstructAvailable(Integer.toBinaryString(binaryLevel));
                }
            }
        }
        instructorRepository.save(instructor);
    }

    private void deleteCertificateImages(Instructor instructor, List<CertificateUrlVO> deleteCertificateUrls) {
        for (CertificateUrlVO certificateUrlVO : deleteCertificateUrls) {
            s3Uploader.deleteFile(certificateUrlVO.getCertificateImageUrl());
            instructorCertRepository.deleteByCertificateImageUrl(certificateUrlVO.getCertificateImageUrl());

            int binaryLevel = Integer.parseInt(instructor.getIsInstructAvailable(), 2);
            binaryLevel ^= convertIdToBinary(certificateUrlVO.getCertificateId());
            instructor.setIsInstructAvailable(Integer.toBinaryString(binaryLevel));
        }
    }

    private int convertIdToBinary(int certificateId) {
        return switch (certificateId) {
            case 1, 4 -> 0b1000001;
            case 2, 5 -> 0b1000010;
            case 3, 6, 7 -> 0b1000011;
            case 8, 11 -> 0b1000100;
            case 9, 12 -> 0b1001000;
            case 10, 13, 14 -> 0b1001100;
            default -> throw new IllegalStateException("Unexpected value: " + certificateId);
        };
    }
}