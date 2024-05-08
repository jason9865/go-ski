package com.go.ski.notification.support.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class NotificationSettingResponseDTO {

    private Integer notificationTypeId;
    private String notificationTypeName;
    private Boolean status;

}
