package com.go.ski.notification.support.events;

import com.fasterxml.jackson.annotation.JsonProperty;
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

    private static final Integer NOTIFICATION_TYPE = 9;

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private Integer senderId;
    private String senderName;
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private Integer receiverId;
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String title;
    private String content;
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private LocalDateTime createdAt;
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private Integer notificationType;
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private DeviceType deviceType;
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String imageUrl;

    public static MessageEvent of(FcmSendRequestDTO requestDTO, User user, String imageUrl, String deviceType){
        MessageEvent messageEvent = new MessageEvent();
        messageEvent.senderId = user.getUserId();
        messageEvent.senderName = user.getUserName();
        messageEvent.receiverId = requestDTO.getReceiverId();
        messageEvent.title = requestDTO.getTitle();
        messageEvent.content = requestDTO.getContent();
        messageEvent.createdAt = LocalDateTime.now();
        messageEvent.notificationType = NOTIFICATION_TYPE;
        messageEvent.deviceType = DeviceType.valueOf(deviceType);
        messageEvent.imageUrl = imageUrl;
        return messageEvent;
    }

}
