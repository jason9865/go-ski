package com.go.ski.notification.support.events;

import com.go.ski.notification.core.domain.DeviceType;
import com.go.ski.notification.support.dto.FcmSendRequestDTO;
import com.go.ski.user.core.model.User;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

import java.time.LocalDateTime;

@Getter
@RequiredArgsConstructor
@ToString
public class MessageEvent {

    private Integer senderId;
    private String senderName;
    private Integer receiverId;
    private String title;
    private String content;
    private LocalDateTime createdAt;
    private Integer notificationType;
    private DeviceType deviceType;
    private String imageUrl;

    public static MessageEvent of(FcmSendRequestDTO requestDTO, User user, String imageUrl){
        MessageEvent messageEvent = new MessageEvent();
        messageEvent.senderId = user.getUserId();
        messageEvent.senderName = user.getUserName();
        messageEvent.receiverId = requestDTO.getReceiverId();
        messageEvent.title = requestDTO.getTitle();
        messageEvent.content = requestDTO.getContent();
        messageEvent.createdAt = LocalDateTime.now();
        messageEvent.notificationType = requestDTO.getNotificationType();
        messageEvent.deviceType = requestDTO.getDeviceType();
        messageEvent.imageUrl = imageUrl;
        return messageEvent;
    }

}
