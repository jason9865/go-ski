package com.go.ski.notification.core.repository;

import com.go.ski.notification.core.domain.NotificationSetting;
import com.go.ski.notification.support.dto.NotificationSettingResponseDTO;
import com.go.ski.user.core.model.User;
import org.aspectj.weaver.ast.Not;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface NotificationSettingRepository extends JpaRepository<NotificationSetting, Integer> {

    @Query("SELECT new com.go.ski.notification.support.dto.NotificationSettingResponseDTO(" +
            "nt.id, nt.notificationTypeName, ns.notificationStatus) " +
            "FROM NotificationSetting ns " +
            "LEFT OUTER JOIN NotificationType nt " +
            "ON ns.notificationType.id = nt.id " +
            "WHERE ns.user = :user")
    List<NotificationSettingResponseDTO> findByUser(User user);

    @Query("SELECT ns " +
            "FROM NotificationSetting ns " +
            "WHERE ns.user.userId = :userId " +
            "AND ns.notificationType.id = :notificationType")
    Optional<NotificationSetting> findByUserIdAndNotificationType(Integer userId, Integer notificationType);

    @Modifying
    @Query("UPDATE NotificationSetting ns " +
            "SET ns.notificationStatus = :status " +
            "WHERE ns.user.userId = :userId " +
            "AND ns.notificationType.id = :notificationType")
    void updateNotificationStatus(Integer notificationType, boolean status, Integer userId);

}
