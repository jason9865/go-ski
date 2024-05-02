package com.go.ski.notification.core.domain;

import jakarta.persistence.*;

@Entity
public class NotificationType{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="notification_type_id")
    private Integer id;

    private String notificationTypeName;



}