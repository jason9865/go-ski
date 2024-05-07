package com.go.ski.notification.support.events;

import com.go.ski.notification.core.domain.DeviceType;
import com.go.ski.notification.support.dto.InviteAcceptRequestDTO;
import com.go.ski.user.core.model.Instructor;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class InviteAcceptEvent extends NotificationEvent{

    private InviteAcceptEvent(
            Integer receiverId, LocalDateTime createdAt,
            Integer notificationType, DeviceType deviceType,
            String title){
        super(receiverId, createdAt, notificationType, deviceType,title);
    }

    public static InviteAcceptEvent of (InviteAcceptRequestDTO requestDTO, Integer userId, Instructor instructor, String deviceType) {
        return new InviteAcceptEvent(
                userId,
                LocalDateTime.now(),
                requestDTO.getNotificationType(),
                DeviceType.valueOf(deviceType),
                instructor.getUser().getUserName() + " 강사가 팀에 초대되었습니다"
        );
    }

}
