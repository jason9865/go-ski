package com.go.ski.notification.support;

import com.go.ski.notification.core.domain.Notification;
import com.go.ski.notification.core.repository.NotificationRepository;
import com.go.ski.notification.core.service.FcmClient;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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


    @Transactional(propagation = Propagation.REQUIRES_NEW)
    @TransactionalEventListener
    public void createNotification(NotificationEvent notificationEvent){
        Notification notification = Notification.from(notificationEvent);
        notificationRepository.save(notification);
        log.warn("알림 보내기 이벤트 리스너가 잘 작동합니다. - {}",notification.getTitle());
        fcmClient.sendMessageTo(notification);
    }

}
