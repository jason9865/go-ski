package com.go.ski.notification.support.events;

import com.go.ski.notification.core.domain.DeviceType;
import lombok.*;
import net.minidev.json.annotate.JsonIgnore;

import java.time.LocalDateTime;


@RequiredArgsConstructor
@Getter
public abstract class NotificationEvent {

    @JsonIgnore
    private final Integer receiverId;
    @JsonIgnore
    private final LocalDateTime createdAt;
    @JsonIgnore
    private final Integer notificationType;
    @JsonIgnore
    private final DeviceType deviceType;
    private final String title;


}
