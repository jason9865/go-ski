package com.go.ski.notification.support.dto;

import com.go.ski.notification.core.domain.DeviceType;
import com.go.ski.notification.core.domain.NotificationType;
import com.go.ski.team.core.model.Team;
import com.go.ski.user.core.model.Instructor;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.time.LocalDateTime;


@Getter
@RequiredArgsConstructor
@ToString
public class InviteRequestDTO extends FcmSendRequestDTO{
    private static final String INVITE_COMPLETE_COMMENT = "강사가 팀에 초대되었습니다.";
    private static final NotificationType notificationType = NotificationType.INVITE;

    private Integer teamId;
    private String instructorName;

    public static InviteRequestDTO of(Integer receiverId, Team team, Instructor instructor){
        InviteRequestDTO inviteRequestDTO = new InviteRequestDTO();
        inviteRequestDTO.setSenderId(instructor.getInstructorId());
        inviteRequestDTO.setReceiverId(receiverId);
        inviteRequestDTO.setTitle(instructor.getUser().getUserName() + INVITE_COMPLETE_COMMENT);
        inviteRequestDTO.setDeviceType(DeviceType.MOBILE);
        inviteRequestDTO.setNotificationType(notificationType);
        inviteRequestDTO.teamId = team.getTeamId();
        inviteRequestDTO.instructorName = team.getTeamName();
        return inviteRequestDTO;
    }
}
