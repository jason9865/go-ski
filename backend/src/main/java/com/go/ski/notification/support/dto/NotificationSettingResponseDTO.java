package com.go.ski.notification.support.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@AllArgsConstructor
public class NotificationSettingResponseDTO {

    private Integer notificationTypeId;
    private Boolean status;

}
