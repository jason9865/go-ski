package com.go.ski.config;

import com.go.ski.notification.support.quartz.QuartzJob;
import com.go.ski.notification.support.quartz.QuartzListener;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.quartz.*;
import org.quartz.impl.StdSchedulerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class QuartzConfig {

    private  Scheduler scheduler;
    private  final ApplicationContext applicationContext;

    // 애플리케이션 영역을 가져오기 위한 이름
    private static final String APPLICATION_NAME = "appContext";

    public QuartzConfig(Scheduler scheduler, ApplicationContext applicationContext) {
        this.scheduler = scheduler;
        this.applicationContext = applicationContext;
    }

    @PostConstruct
    private void jobProgress() {
        try{
            cronScheduler();
        } catch (SchedulerException e){
            throw new RuntimeException("스케줄러 실행 도중 에러 발생");
        }
    }

    private void cronScheduler() throws SchedulerException{
        JobDataMap ctx = new JobDataMap(); // 스케줄러에게 애플리케이션 영역 추가
        ctx.put(APPLICATION_NAME,applicationContext);

        JobDetail job = JobBuilder
                .newJob(QuartzJob.class)                                   // Job 구현 클래스
                .withIdentity("QuartzJob", "go-ski")     // Job 이름, 그룹 지정
                .withDescription("강습 알림")   // Job 설명
                .setJobData(ctx)
                .build();

        CronTrigger cronTrigger = TriggerBuilder
                .newTrigger()
                .withIdentity("LessonAlertEvent Trigger", "go-ski")         // Trigger 이름, 그룹 지정
                .withDescription("현재 시간 기준으로 1시간 남은 강습이 있는지 확인 - 30분 마다 실행 Trigger")     // Trigger 설명
                .startNow()
                .withSchedule(CronScheduleBuilder.cronSchedule("/10 * * * * ?")).build();

        scheduler = new StdSchedulerFactory().getScheduler();
        QuartzListener quartzListener = new QuartzListener();
        scheduler.getListenerManager().addJobListener(quartzListener);
        scheduler.start();
        scheduler.scheduleJob(job, cronTrigger);
    }

}
