package com.go.ski.notification.core.domain;

import com.go.ski.user.core.model.User;
import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;

@Entity
public class NotificationSetting {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="notification_setting_id")
    private Integer id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="notification_type_id")
    private NotificationType notificationType;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id")
    private User user;

    @ColumnDefault("1")
    private byte noticiationStatus;

}
