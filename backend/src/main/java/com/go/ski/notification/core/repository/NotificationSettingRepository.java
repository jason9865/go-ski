package com.go.ski.notification.core.repository;

import com.go.ski.notification.core.domain.NotificationSetting;
import com.go.ski.user.core.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface NotificationSettingRepository extends JpaRepository<NotificationSetting, Integer> {

    @Query("SELECT ns " +
            "FROM NotificationSetting ns " +
            "WHERE ns.user.userId = :userId " +
            "AND ns.notificationType.id = :notificationType")
    Optional<NotificationSetting> findByUserIdAndNotificationType(Integer userId, Integer notificationType);

}
