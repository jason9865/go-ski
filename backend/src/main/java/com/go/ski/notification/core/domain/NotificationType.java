package com.go.ski.notification.core.domain;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

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