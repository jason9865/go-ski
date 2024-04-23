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
import com.go.ski.user.support.dto.InstructorCertificateDTO;
import com.go.ski.user.support.dto.ProfileImageDTO;
import com.go.ski.user.support.dto.SignupRequestDTO;
import com.go.ski.user.support.dto.UpdateInstructorRequestDTO;
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

    @Transactional
    public User signupUser(User domainUser, SignupRequestDTO signupRequestDTO) {
        User user = User.builder()
                .domain(domainUser.getDomain())
                .userName(signupRequestDTO.getUserName())
                .birthDate(signupRequestDTO.getBirthDate())
                .phoneNumber(signupRequestDTO.getPhoneNumber())
                .gender(signupRequestDTO.getGender())
                .role(signupRequestDTO.getRole())
                .profileUrl(domainUser.getProfileUrl())
                .build();

        // 프로필 이미지 업로드 후 save
        uploadProfileImage(user, signupRequestDTO);

        if ("INSTRUCTOR".equals(user.getRole().name())) {
            Instructor instructor = Instructor.builder()
                    .instructorId(user.getUserId())
                    .user(user)
                    .build();
            instructorRepository.save(instructor);

            // 자격증 사진 업로드 후 save
            uploadCertificateImages(instructor, signupRequestDTO);
        }
        return user;
    }

    public void logout(HttpServletResponse response) {
        String refreshToken = response.getHeader("refreshToken");
        jwtUtil.deleteToken(refreshToken);
        response.setHeader("accessToken", null);
        response.setHeader("refreshToken", null);
    }

    public void updateUser(int userId, ProfileImageDTO profileImageDTO) {
        User user = userRepository.findById(userId).orElseThrow();
        uploadProfileImage(user, profileImageDTO);
    }

    @Transactional
    public void updateInstructor(int userId, UpdateInstructorRequestDTO updateInstructorRequestDTO) {
        User user = userRepository.findById(userId).orElseThrow();
        uploadProfileImage(user, updateInstructorRequestDTO);

        Instructor instructor = instructorRepository.findById(userId).orElseThrow();
        instructor.setDescription(updateInstructorRequestDTO.getDescription());
        instructor.setDayoff(updateInstructorRequestDTO.getDayoff());
        instructor.setIsInstructAvailable(updateInstructorRequestDTO.getIsInstructAvailable());
        instructorRepository.save(instructor);

        uploadCertificateImages(instructor, updateInstructorRequestDTO);
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

    private void uploadCertificateImages(Instructor instructor, InstructorCertificateDTO instructorCertificateDTO) {
        List<CertificateVO> certificateVOs = instructorCertificateDTO.getCertificateVOs();
        if (certificateVOs != null && !certificateVOs.isEmpty()) {
            for (CertificateVO certificateVO : certificateVOs) {
                log.info("{}", certificateVO);

                Optional<Certificate> optionalCertificate = certificateRepository.findById(certificateVO.getCertificateId());
                if (optionalCertificate.isPresent()) {
                    String certificateImageUrl = s3Uploader.uploadFile("certificate/" + instructor.getInstructorId(), certificateVO.getCertificateImage());
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