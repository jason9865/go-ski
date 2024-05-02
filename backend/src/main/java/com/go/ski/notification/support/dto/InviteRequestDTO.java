package com.go.ski.notification.support.dto;

import com.go.ski.notification.core.domain.DeviceType;
import com.go.ski.notification.core.domain.NotificationType;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Getter
@RequiredArgsConstructor
@ToString
public class InviteRequestDTO {

    private Integer teamId;
    private Integer receiverId;
    private Integer notificationType;
    private DeviceType deviceType;

}
