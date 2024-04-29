package com.go.ski.Notification.core.repository;

import com.go.ski.Notification.core.domain.Notification;
import com.go.ski.Notification.support.dto.NotificationResponseDTO;
import com.go.ski.user.core.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;


import java.util.List;

public interface NotificationRepository extends JpaRepository<Notification, Integer> {

//    @Query("SELECT n FROM Notification n WHERE n.receiverId = :receiverId")
//    List<Notification> findByReceiverId(Integer receiverId);

    @Query("SELECT new com.go.ski.Notification.support.dto.NotificationResponseDTO(" +
            "n.notificationId, n.senderId, u.userName, n.type, n.title, n.content, n.imageUrl, n.isRead) " +
            "FROM Notification n " +
            "LEFT OUTER JOIN User u " +
            "ON n.senderId = u.userId " +
            "WHERE n.receiverId = :receiverId")
    List<NotificationResponseDTO> findByReceiverId(Integer receiverId);

}
