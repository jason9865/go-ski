package com.go.ski.notification.core.domain;

import com.go.ski.notification.support.dto.FcmSendRequestDTO;
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

    @Column(nullable = false)
    private Integer receiverId;

    @Column(nullable = false)
    private Integer senderId;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private NotificationType type;

    @Column(nullable = false)
    private String title;

    private String content;

    private String imageUrl;

    @ColumnDefault("0")
    private byte isRead;

    public static Notification of(FcmSendRequestDTO dto,String imageUrl) {
        return Notification.builder()
                .receiverId(dto.getReceiverId())
                .senderId(dto.getSenderId())
                .type(dto.getNotificationType())
                .title(dto.getTitle())
                .content(dto.getContent())
                .imageUrl(imageUrl)
                .build()
                ;
    }

    public void read(){
        isRead = 1;
    }

}
