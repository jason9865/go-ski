package com.go.ski.redis.dto;

import com.go.ski.schedule.support.vo.ReserveScheduleVO;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;
import org.springframework.data.redis.core.RedisHash;
import org.springframework.data.redis.core.TimeToLive;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Getter
@RedisHash(value = "scheduleCache")
@AllArgsConstructor
@ToString
public class ScheduleCacheDto {

    @Id
    private String id; // lessonDate:teamId:instructorId
    private List<ReserveScheduleVO> reserveScheduleVOs;

    @TimeToLive(unit = TimeUnit.MILLISECONDS)
    private long expiration;

    public ScheduleCacheDto(String id, List<ReserveScheduleVO> reserveScheduleVOs, LocalDate lessonDate) {
        this.id = id;
        this.reserveScheduleVOs = reserveScheduleVOs;
        this.expiration = calculateExpiration(lessonDate);
    }

    private long calculateExpiration(LocalDate expirationDate) {
        LocalDateTime expirationDateTime = expirationDate.plusDays(1).atStartOfDay();
        LocalDateTime now = LocalDateTime.now();
        Duration duration = Duration.between(now, expirationDateTime);
        return duration.toMillis();
    }
}
