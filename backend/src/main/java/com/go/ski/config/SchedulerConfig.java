package com.go.ski.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableScheduling
@EnableTransactionManagement
public class SchedulerConfig {
    // 이곳에 스케줄러 설정 코드를 추가할 수 있습니다.
}