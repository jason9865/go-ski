package com.go.ski.notification.support.events;

import com.go.ski.notification.core.domain.DeviceType;
import com.go.ski.notification.support.dto.InviteRequestDTO;
import com.go.ski.team.core.model.Team;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class InviteEvent extends NotificationEvent{

    private final Integer teamId;

    private InviteEvent(
            Integer receiverId, LocalDateTime createdAt,
            Integer notificationType, DeviceType deviceType,
            String title, Integer teamId){
        super(receiverId, createdAt, notificationType, deviceType,title);
        this.teamId = teamId;
    }

    public static InviteEvent of(InviteRequestDTO inviteRequestDTO, Team team, String deviceType) {
        return new InviteEvent(
                inviteRequestDTO.getReceiverId(),
                LocalDateTime.now(),
                inviteRequestDTO.getNotificationType(),
                DeviceType.valueOf(deviceType),
                team.getTeamName() + "에서 팀 초대 요청이 왔습니다.",
                team.getTeamId()
        );
    }

}
