package com.go.ski.notification.support.dto;

import com.go.ski.notification.core.domain.DeviceType;
import com.go.ski.notification.core.domain.NotificationType;
import com.go.ski.team.core.model.Team;
import com.go.ski.user.core.model.Instructor;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.time.LocalDateTime;


@Getter
@RequiredArgsConstructor
@ToString
public class InviteRequestDTO extends FcmSendRequestDTO{
    private Integer teamId;
    private String instructorName;

}
