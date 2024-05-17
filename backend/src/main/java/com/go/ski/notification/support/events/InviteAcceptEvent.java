package com.go.ski.notification.support.events;

import com.go.ski.notification.core.domain.DeviceType;
import com.go.ski.notification.support.dto.InviteAcceptRequestDTO;
import com.go.ski.user.core.model.Instructor;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class InviteAcceptEvent extends NotificationEvent{
    private static final Integer NOTIFICATION_TYPE = 5;

    private Integer teamId;

    private InviteAcceptEvent(
            Integer receiverId, LocalDateTime createdAt,
            Integer notificationType, DeviceType deviceType,
            String title, Integer teamId){
        super(receiverId, createdAt, notificationType, deviceType,title);
        this.teamId = teamId;
    }

    public static InviteAcceptEvent of (InviteAcceptRequestDTO requestDTO, Integer userId, Instructor instructor, String deviceType) {
        return new InviteAcceptEvent(
                userId,
                LocalDateTime.now(),
                NOTIFICATION_TYPE,
                DeviceType.valueOf(deviceType),
                instructor.getUser().getUserName() + " 강사가 팀에 초대되었습니다",
                requestDTO.getTeamId()
        );
    }

}
