package com.go.ski.notification.support.events;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.go.ski.notification.core.domain.DeviceType;
import lombok.*;
import net.minidev.json.annotate.JsonIgnore;

import java.time.LocalDateTime;


@RequiredArgsConstructor
@Getter
public abstract class NotificationEvent {

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private final Integer receiverId;
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private final LocalDateTime createdAt;
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private final Integer notificationType;
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private final DeviceType deviceType;
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private final String title;


}
