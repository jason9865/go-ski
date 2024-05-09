package com.go.ski.notification.core.domain;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@ToString
public class NotificationType{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="notification_type_id")
    private Integer id;

    private String notificationTypeName;

}