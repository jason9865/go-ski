package com.go.ski.Notification.core.repository;

import com.go.ski.Notification.core.domain.Notification;
import com.go.ski.user.core.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface NotificationRepository extends JpaRepository<Notification, Integer> {

    List<Notification> findByUser(User user);

}
