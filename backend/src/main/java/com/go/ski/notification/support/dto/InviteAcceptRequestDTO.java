package com.go.ski.notification.support.dto;

import com.go.ski.notification.core.domain.DeviceType;
import com.go.ski.notification.core.domain.NotificationType;
import lombok.*;


@Getter
@RequiredArgsConstructor
@ToString
public class InviteAcceptRequestDTO{
    private Integer teamId;
    private DeviceType deviceType;
    private Integer notificationType;
}
