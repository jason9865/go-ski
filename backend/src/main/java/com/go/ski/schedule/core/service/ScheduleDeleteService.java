package com.go.ski.schedule.core.service;

import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.model.LessonInfo;
import com.go.ski.payment.core.repository.LessonInfoRepository;
import com.go.ski.payment.core.repository.LessonRepository;
import com.go.ski.payment.core.service.PayService;
import com.go.ski.payment.support.dto.request.CancelPaymentRequestDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
public class ScheduleDeleteService {
    private final LessonRepository lessonRepository;
    private final LessonInfoRepository lessonInfoRepository;
    private final PayService payService;
    private final ScheduleService scheduleService;

    @Transactional
    public void deleteSchedule(Integer lessonId) {
        Lesson lesson = lessonRepository.findById(lessonId).orElseThrow();
        LessonInfo lessonInfo = lessonInfoRepository.findById(lessonId).orElseThrow();
        if (lesson.getIsOwn() == 1) {
            lessonRepository.delete(lesson);
            scheduleService.scheduleCaching(lesson.getTeam(), lessonInfo.getLessonDate());
        } else {
            payService.getCancelResponse(new CancelPaymentRequestDTO(lessonId));
        }
    }
}
