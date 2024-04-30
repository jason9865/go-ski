package com.go.ski.notification.support;

import com.go.ski.notification.core.service.FcmClient;
import com.go.ski.notification.support.dto.InviteRequestDTO;
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

    @Transactional(propagation = Propagation.REQUIRES_NEW)
    @TransactionalEventListener
    public void createNotification(InviteRequestDTO inviteRequestDTO) {
        fcmClient.sendMessageTo(inviteRequestDTO);
        log.warn("이벤트 리스너가 잘 작동합니다. - {}",inviteRequestDTO.getTitle());
    }

}
