package com.go.ski.notification.core.service;

import com.go.ski.common.util.S3Uploader;
import com.go.ski.notification.core.domain.Notification;
import com.go.ski.notification.core.domain.NotificationSetting;
import com.go.ski.notification.core.repository.NotificationRepository;
import com.go.ski.notification.core.repository.NotificationSettingRepository;
import com.go.ski.notification.support.EventPublisher;
import com.go.ski.notification.support.dto.*;
import com.go.ski.notification.support.exception.NotificationExceptionEnum;
import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.notification.support.vo.NotificationSettingVO;
import com.go.ski.team.core.model.Team;
import com.go.ski.team.core.model.TeamInstructor;
import com.go.ski.team.core.repository.TeamInstructorRepository;
import com.go.ski.team.core.repository.TeamRepository;
import com.go.ski.team.support.exception.TeamExceptionEnum;
import com.go.ski.user.core.model.Instructor;
import com.go.ski.user.core.model.User;
import com.go.ski.user.core.repository.InstructorRepository;
import com.go.ski.user.core.repository.UserRepository;
import com.go.ski.user.support.exception.UserExceptionEnum;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

import static com.go.ski.common.constant.FileUploadPath.NOTIFICATION_IMAGE_PATH;

@Slf4j
@Service
@RequiredArgsConstructor
public class NotificationService {

    private final UserRepository userRepository;
    private final TeamRepository teamRepository;
    private final TeamInstructorRepository teamInstructorRepository;
    private final InstructorRepository instructorRepository;
    private final NotificationRepository notificationRepository;
    private final NotificationSettingRepository notificationSettingRepository;
    private final S3Uploader s3Uploader;
    private final EventPublisher eventPublisher;

    @Transactional
    public void registerFcmToken(User user, FcmTokenRequestDTO requestDTO) {
        String token = requestDTO.getToken();
        String tokenType = requestDTO.getTokenType();
        log.info("tokenType -> {}",tokenType);

        if (tokenType.equals("WEB")) {
            user.updateFcmWeb(token);
        }
        else {
            user.updateFcmMobile(token);
        }
        userRepository.save(user);
    }

    public List<NotificationResponseDTO> findAllNotifications(User user) {
        return notificationRepository.findByReceiverId(user.getUserId());
    }

    @Transactional
    public void readAll(User user) {
        notificationRepository.readAllNotifications(user.getUserId());
    }

    @Transactional
    public void delete(Integer notificationId, User user) {
        Notification notification = notificationRepository.findById(notificationId)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(NotificationExceptionEnum.NOTIFICATION_NOT_FOUND));

        validateUser(notification, user);
        if(notification.getImageUrl() != null) {
            s3Uploader.deleteFile(notification.getImageUrl());
        }

        notificationRepository.delete(notification);
    }

    @Transactional
    public void sendMessage(HttpServletRequest request, FcmSendRequestDTO fcmSendRequestDTO, MultipartFile image){
        User user = (User)request.getAttribute("user");
        String deviceType = request.getHeader("DeviceType");
        String imageUrl = image != null ?
                s3Uploader.uploadFile(NOTIFICATION_IMAGE_PATH.path, image) :
                null;

        log.info("imageurl - {}",imageUrl);

        eventPublisher.publish(fcmSendRequestDTO, user, imageUrl , deviceType);
    }

    @Transactional
    public void sendInvite(InviteRequestDTO inviteRequestDTO, HttpServletRequest request) {
        Team team = getTeam(inviteRequestDTO.getTeamId());
        Instructor instructor = getInstructor(inviteRequestDTO.getReceiverId());
        validateInvite(team, instructor);

        String deviceType = request.getHeader("DeviceType");
        eventPublisher.publish(inviteRequestDTO, team, deviceType);
    }

    public List<NotificationSettingResponseDTO> getNotifications(User user) {
        return notificationSettingRepository.findByUser(user);
    }

    @Transactional
    public void setNotifications(NotificationSettingRequestDTO setNotificationRequestDTO, User user) {
        List<NotificationSettingVO> notificationTypes = setNotificationRequestDTO.getNotificationTypes();
        for(NotificationSettingVO vo : notificationTypes) {
            notificationSettingRepository.updateNotificationStatus(vo.getNotificationType(), vo.getStatus(), user.getUserId());
        }

    }

    public Team getTeam(Integer teamId){
        return teamRepository.findById(teamId)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(TeamExceptionEnum.TEAM_NOT_FOUND));
    }

    public Instructor getInstructor(Integer instructorId){
        return instructorRepository.findById(instructorId)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(UserExceptionEnum.USER_NOT_FOUND));
    }

    public void validateUser(Notification notification,User user) {
        if(notification.getReceiverId() != user.getUserId()){
            throw ApiExceptionFactory.fromExceptionEnum(NotificationExceptionEnum.NOTIFICATION_UNAUTHORIZED);
        }
    }


    private void validateInvite(Team team, Instructor instructor) {
        TeamInstructor teamInstructor = teamInstructorRepository.findByTeamAndInstructor(team, instructor).orElse(null);
        if(teamInstructor != null) {
            throw ApiExceptionFactory.fromExceptionEnum(TeamExceptionEnum.TEAM_INSTRUCTOR_EXISTS);
        }
    }

}
