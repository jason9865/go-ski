package com.go.ski.Notification.core.domain;

import com.go.ski.user.core.model.User;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@ToString
public class Notification {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer notificationId;

    @ManyToOne
    @JoinColumn(name="receiver_id", referencedColumnName = "userId")
    private User user;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private NotificationType type;

    @Column(nullable = false)
    private String title;

    private String content;

    private String imageUrl;

    @ColumnDefault("0")
    private byte isRead;

    public void read(){
        this.isRead = 1;
    }

}
