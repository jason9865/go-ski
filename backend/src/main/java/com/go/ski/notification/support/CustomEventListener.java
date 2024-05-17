package com.go.ski.notification.support;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.notification.core.domain.Notification;
import com.go.ski.notification.core.repository.NotificationRepository;
import com.go.ski.notification.core.repository.NotificationSettingRepository;
import com.go.ski.notification.core.service.FcmClient;
import com.go.ski.notification.support.events.LessonAlertEvent;
import com.go.ski.notification.support.events.MessageEvent;
import com.go.ski.notification.support.events.NotificationEvent;
import com.go.ski.notification.support.exception.NotificationExceptionEnum;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.event.TransactionalEventListener;

@Slf4j
@Component
@RequiredArgsConstructor
public class CustomEventListener {

    private final FcmClient fcmClient;
    private final NotificationRepository notificationRepository;
    private final NotificationSettingRepository notificationSettingRepository;
    private final ObjectMapper objectMapper;


    @Transactional(propagation = Propagation.REQUIRES_NEW)
    @TransactionalEventListener // @Transaction이 붙은 Event
    public void createNotification(NotificationEvent notificationEvent){
        log.info("EventListener - createNotification");
        try{
            String jsonContent = objectMapper.writeValueAsString(notificationEvent);
            Notification notification = Notification.of(notificationEvent, jsonContent);
            notificationRepository.save(notification);

            if (isSendAvailable(notification.getReceiverId(), notification.getNotificationType())){
                log.warn("알림 보내기 - {}",notification.getTitle());
                fcmClient.sendMessageTo(notification);
            }
        } catch(JsonProcessingException e) {
            log.error("json error");
        }
    }

    @Transactional(propagation = Propagation.REQUIRES_NEW)
    @TransactionalEventListener
    public void createMessage(MessageEvent messageEvent) {

            Notification notification = Notification.from(messageEvent);
            notificationRepository.save(notification);

            if (isSendAvailable(notification.getReceiverId(), notification.getNotificationType())){
                log.warn("DM 보내기 - {}",notification.getTitle());
                fcmClient.sendMessageTo(messageEvent);
            }

    }

    @EventListener // @Transaction이 붙지 않은 Event
    public void createLessonMessage(LessonAlertEvent lessonAlertEvent) {
        try {
            String jsonContent = objectMapper.writeValueAsString(lessonAlertEvent);
            Notification notification = Notification.of(lessonAlertEvent,jsonContent);
            notificationRepository.save(notification);

            if (isSendAvailable(notification.getReceiverId(), notification.getNotificationType())){
                log.warn("알림 보내기 - {}",notification.getTitle());
                fcmClient.sendMessageTo(notification);
            }
        } catch(JsonProcessingException e) {
        log.error("json error");
    }

    }

    public boolean isSendAvailable(Integer userId, Integer notificationType) {
        return notificationSettingRepository.findByUserIdAndNotificationType(userId,notificationType)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(NotificationExceptionEnum.NOTIFICATION_SETTING_NOT_FOUND))
                .isNotificationStatus();
    }

}
