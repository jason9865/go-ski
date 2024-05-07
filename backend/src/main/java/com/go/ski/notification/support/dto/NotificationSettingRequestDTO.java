package com.go.ski.notification.support.dto;

import com.go.ski.notification.support.vo.NotificationSettingVO;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.List;

@Getter
@RequiredArgsConstructor
public class NotificationSettingRequestDTO {

    List<NotificationSettingVO> notificationTypes;
}
