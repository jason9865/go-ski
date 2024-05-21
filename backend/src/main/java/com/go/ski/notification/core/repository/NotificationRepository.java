package com.go.ski.notification.core.repository;

import com.go.ski.notification.core.domain.Notification;
import com.go.ski.notification.support.dto.NotificationResponseDTO;
import com.go.ski.user.core.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;


import java.util.List;

public interface NotificationRepository extends JpaRepository<Notification, Integer> {

//    @Query("SELECT n FROM Notification n WHERE n.receiverId = :receiverId")
//    List<Notification> findByReceiverId(Integer receiverId);

    @Query("SELECT new com.go.ski.notification.support.dto.NotificationResponseDTO(" +
            "n.notificationId,n.notificationType,  n.createdAt, n.isRead,  n.title, n.content, n.imageUrl, n.senderId, u.userName) " +
            "FROM Notification n " +
            "LEFT OUTER JOIN User u " +
            "ON n.senderId = u.userId " +
            "WHERE n.receiverId = :receiverId " +
            "ORDER BY n.createdAt DESC")
    List<NotificationResponseDTO> findByReceiverId(Integer receiverId);

    @Modifying
    @Query("UPDATE Notification n " +
            "SET n.isRead = 1 " +
            "WHERE n.receiverId = :receiverId " +
            "AND n.isRead = 0")
     void readAllNotifications(Integer receiverId);

}
