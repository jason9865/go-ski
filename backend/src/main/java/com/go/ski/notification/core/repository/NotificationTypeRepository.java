package com.go.ski.notification.core.repository;

import com.go.ski.notification.core.domain.NotificationType;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NotificationTypeRepository extends JpaRepository<NotificationType, Integer> {
}

