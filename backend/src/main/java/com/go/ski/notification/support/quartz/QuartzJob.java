package com.go.ski.notification.support.quartz;

import com.go.ski.common.util.TimeConvertor;
import com.go.ski.notification.core.service.FcmClient;
import com.go.ski.notification.support.EventPublisher;
import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.model.LessonInfo;
import com.go.ski.payment.core.repository.LessonInfoRepository;
import com.go.ski.payment.core.repository.LessonRepository;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Time;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Slf4j
public class QuartzJob implements Job {
    private static final LocalDate LESSON_DATE = LocalDate.now();
    private static final Integer LESSON_STATUS = 0;

    private  EventPublisher eventPublisher;
    private  LessonInfoRepository lessonInfoRepository;

    @Override
    public void execute(JobExecutionContext jobExecutionContext) {
        // QuartzConfig에서 jobDataMap에 저장해둔 ApplicationContext 꺼내와서 사용
        ApplicationContext applicationContext = (ApplicationContext) jobExecutionContext.
                getJobDetail().getJobDataMap().get("appContext");
        
        // ApplicationContext에서 EventPublisher와 LessonInfoRepository를 꺼내와서 JobExecutionContext에 빈 등록
        if (eventPublisher == null) {
            eventPublisher = applicationContext.getBean(EventPublisher.class);
        }

        if (lessonInfoRepository == null) {
            lessonInfoRepository = applicationContext.getBean(LessonInfoRepository.class);
        }

        List<LessonInfo> lessonList = lessonInfoRepository.findByLessonDateAndLessonStatus(LESSON_DATE, LESSON_STATUS);

        log.info("lessonlist의 길이 - {}",lessonList.size());

        log.info("현재 시간 - {}",LocalDateTime.now());

        for (LessonInfo lessonInfo : lessonList) {
            LocalDateTime now = LocalDateTime.now();
            LocalDateTime startTime = LocalDateTime.now()
                    .withHour(Integer.parseInt(lessonInfo.getStartTime().substring(0,2)))
                    .withMinute(Integer.parseInt(lessonInfo.getStartTime().substring(2,4)))
                    .withSecond(0);

            log.info("시작 시간 - {}",startTime);
            Duration duration = Duration.between(now,startTime);

            log.info("레슨까지 남은 시간 - {}",duration.toMinutes());

            if (duration.toHours() <= 1 && duration.toMinutes() > 30) {
                Lesson lesson = lessonInfo.getLesson();
                eventPublisher.publish(lessonInfo, lesson);
            }
        }
    }
}
