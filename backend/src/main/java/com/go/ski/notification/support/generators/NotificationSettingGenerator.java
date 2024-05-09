package com.go.ski.notification.support.generators;

import com.go.ski.notification.core.domain.NotificationSetting;
import com.go.ski.notification.core.domain.NotificationType;
import com.go.ski.notification.core.repository.NotificationSettingRepository;
import com.go.ski.notification.core.repository.NotificationTypeRepository;
import com.go.ski.user.core.model.User;
import com.go.ski.user.support.vo.Role;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class NotificationSettingGenerator {

    private final static List<Integer> OWNER_NOTIFICATION_TYPES = Arrays.asList(1,2,3,4);
    private final static List<Integer> INSTRUCTOR_NOTIFICATION_TYPES = Arrays.asList(2,3,4,5,6);
    private final static List<Integer> STUDENT_NOTIFICATION_TYPES = Arrays.asList(7,8,9);

    private final NotificationTypeRepository notificationTypeRepository;
    private final NotificationSettingRepository notificationSettingRepository;

    public void createNotificationSettings(User user) {
        Role role = user.getRole();
        switch (role) {
            case STUDENT -> saveSetting(user, STUDENT_NOTIFICATION_TYPES);
            case OWNER -> saveSetting(user, OWNER_NOTIFICATION_TYPES);
            default -> saveSetting(user, INSTRUCTOR_NOTIFICATION_TYPES);
        }
    }

    private void saveSetting(User user, List<Integer> notificationTypes) {
        List<NotificationType> notificationTypeList = notificationTypeRepository.findAllById(notificationTypes);
        List<NotificationSetting> settings = notificationTypeList.stream()
                .map(notificationType -> NotificationSetting.builder()
                        .notificationType(notificationType)
                        .user(user)
                        .notificationStatus(true)
                        .build())
                .collect(Collectors.toList());
        notificationSettingRepository.saveAll(settings);
    }

}
