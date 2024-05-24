package com.go.ski.schedule.core.service;

import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.lesson.support.vo.LessonScheduleVO;
import com.go.ski.notification.support.EventPublisher;
import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.model.LessonInfo;
import com.go.ski.payment.core.model.LessonPaymentInfo;
import com.go.ski.payment.core.repository.LessonInfoRepository;
import com.go.ski.payment.core.repository.LessonPaymentInfoRepository;
import com.go.ski.payment.core.repository.LessonRepository;
import com.go.ski.payment.core.repository.StudentInfoRepository;
import com.go.ski.payment.support.dto.util.StudentInfoDTO;
import com.go.ski.redis.dto.ScheduleCacheDto;
import com.go.ski.redis.repository.ScheduleCacheRepository;
import com.go.ski.schedule.support.exception.ScheduleExceptionEnum;
import com.go.ski.schedule.support.vo.ReserveScheduleVO;
import com.go.ski.team.core.model.Permission;
import com.go.ski.team.core.model.Team;
import com.go.ski.team.core.model.TeamInstructor;
import com.go.ski.team.core.repository.PermissionRepository;
import com.go.ski.team.core.repository.TeamInstructorRepository;
import com.go.ski.team.core.repository.TeamRepository;
import com.go.ski.user.core.model.Instructor;
import com.go.ski.user.core.model.User;
import com.go.ski.user.core.repository.InstructorRepository;
import com.go.ski.user.core.repository.UserRepository;
import com.go.ski.user.support.vo.Role;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class ScheduleService {
    private final LessonRepository lessonRepository;
    private final LessonInfoRepository lessonInfoRepository;
    private final UserRepository userRepository;
    private final TeamRepository teamRepository;
    private final InstructorRepository instructorRepository;
    private final TeamInstructorRepository teamInstructorRepository;
    private final StudentInfoRepository studentInfoRepository;
    private final LessonPaymentInfoRepository lessonPaymentInfoRepository;
    private final PermissionRepository permissionRepository;
    private final ScheduleCacheRepository scheduleCacheRepository;
    private final RedisTemplate<String, Object> redisTemplate;
    private final EventPublisher eventPublisher;
    @PersistenceContext
    private EntityManager entityManager;

    public List<ReserveScheduleVO> getMySchedule(User user) {
        // 소속 팀 + userId로 현재 이후의 스케줄 조회
        Set<String> keys = redisTemplate.keys("scheduleCache:" + user.getUserId() + ":*");
        return getReserveScheduleVOS(keys);
    }

    public List<ReserveScheduleVO> getTeamSchedule(User user, int teamId, LocalDate lessonDate) {
        Optional<TeamInstructor> optionalTeamInstructor = teamInstructorRepository.findByTeamTeamIdAndInstructorInstructorIdAndIsInviteAccepted(teamId, user.getUserId(), true);
        if (optionalTeamInstructor.isEmpty()) {
            throw ApiExceptionFactory.fromExceptionEnum(ScheduleExceptionEnum.NOT_MEMBER_OF_TEAM);
        }

        Set<String> keys = redisTemplate.keys("scheduleCache:*:" + teamId + ":" + lessonDate);
        return getReserveScheduleVOS(keys);
    }

    private List<ReserveScheduleVO> getReserveScheduleVOS(Set<String> keys) {
        log.info("keys: {}", keys);

        List<ReserveScheduleVO> result = new ArrayList<>();
        if (keys != null && !keys.isEmpty()) {
            for (String key : keys) {
                Optional<ScheduleCacheDto> scheduleCacheDto = scheduleCacheRepository.findById(key.substring(14));
                if (scheduleCacheDto.isPresent()) {
                    List<ReserveScheduleVO> reserveScheduleVOs = scheduleCacheDto.get().getReserveScheduleVOs();
                    if (reserveScheduleVOs != null) {
                        result.addAll(reserveScheduleVOs);
                    }
                }
            }
        }
        return result;
    }

    public boolean checkAddPermission(User user, Integer teamId) {
        if (user.getRole().equals(Role.OWNER)) {
            Team team = teamRepository.findById(teamId).orElseThrow();
            return user.equals(team.getUser());
        } else {
            Permission permission = permissionRepository.findByTeamInstructorInstructorInstructorIdAndTeamInstructorTeamTeamId(user.getUserId(), teamId).orElseThrow();
            return permission.isAddPermission();
        }
    }

    public boolean checkPermission(User user, Integer lessonId, int type) {
        Lesson lesson = lessonRepository.findById(lessonId).orElseThrow();
        if (user.getRole().equals(Role.OWNER)) {
            return user.equals(lesson.getTeam().getUser());
        } else {
            Permission permission = permissionRepository.findByTeamInstructorInstructorInstructorIdAndTeamInstructorTeamTeamId(user.getUserId(), lesson.getTeam().getTeamId()).orElseThrow();
            if (type == 1) {
                return permission.isDeletePermission();
            } else {
                return permission.isModifyPermission() && lesson.getIsOwn() == 1;
            }
        }
    }

    @Transactional
    public void createSchedule(ReserveScheduleVO reserveScheduleVO) {
        User user = userRepository.findById(1).orElseThrow();
        Team team = teamRepository.findById(reserveScheduleVO.getTeamId()).orElseThrow();
        Instructor instructor = null;
        if (reserveScheduleVO.getInstructorId() != null) {
            instructor = instructorRepository.findById(reserveScheduleVO.getInstructorId()).orElseThrow();
        }
        Lesson lesson = lessonRepository.save(new Lesson(reserveScheduleVO.getLessonId(), user, team, instructor, reserveScheduleVO.getRepresentativeName()));
        lessonInfoRepository.save(new LessonInfo(lesson, reserveScheduleVO));

        if (!scheduleCaching(team, reserveScheduleVO.getLessonDate())) {
            throw ApiExceptionFactory.fromExceptionEnum(ScheduleExceptionEnum.FAIL_ADD_SCHEDULE);
        }
    }

    public boolean scheduleCaching(Team team, LocalDate lessonDate) {
        // 해당 팀에 소속된 강사 리스트
        List<TeamInstructor> teamInstructors = teamInstructorRepository.findByTeamAndIsInviteAccepted(team, true);
        // 강습 일자, 팀으로 이미 예약된 강습 리스트
        List<LessonInfo> lessonInfos = lessonInfoRepository.findByLessonDateAndLessonTeamAndLessonStatus(lessonDate, team, 0);
        // lessonInfo를 ReserveScheduleVO로 변환
        List<ReserveScheduleVO> reserveScheduleVOs = new ArrayList<>();
        for (LessonInfo lessonInfo : lessonInfos) {
            List<StudentInfoDTO> studentInfoDTOs = studentInfoRepository.findByLessonInfo(lessonInfo).stream()
                    .map(StudentInfoDTO::new).toList();
            LessonPaymentInfo lessonPaymentInfo = lessonPaymentInfoRepository.findById(lessonInfo.getLesson().getLessonId()).orElse(null);
            if (!studentInfoDTOs.isEmpty() && lessonPaymentInfo != null) {
                reserveScheduleVOs.add(new ReserveScheduleVO(lessonInfo, studentInfoDTOs, lessonPaymentInfo));
            }
        }

        Map<Integer, List<ReserveScheduleVO>> reserveScheduleMap = assignLessons(reserveScheduleVOs, teamInstructors);
        log.info("{}", reserveScheduleMap);
        if (reserveScheduleMap != null) {
            // 예약이 가능하면 기존에 저장되어 있던 것들을 지우고 새로 저장해야함
            String id = team.getTeamId() + ":" + lessonDate;
            reserveScheduleMap.forEach((instructorId, ReserveScheduleVOs) ->
                    scheduleCacheRepository.save(new ScheduleCacheDto(instructorId + ":" + id, ReserveScheduleVOs, lessonDate)));
            return true;
        }
        return false;
    }

    // 예약을 배정할 수 있는 지 판단하는 메서드
    private Map<Integer, List<ReserveScheduleVO>> assignLessons(List<ReserveScheduleVO> reserveScheduleVOs, List<TeamInstructor> teamInstructors) {
        // 팀에 소속된 강사들 스케줄 맵 만들기
        Map<Integer, LessonScheduleVO> lessonInfoMap = new HashMap<>();
        Map<Integer, List<ReserveScheduleVO>> reserveScheduleMap = new HashMap<>();
        for (TeamInstructor teamInstructor : teamInstructors) {
            Instructor getInstructor = teamInstructor.getInstructor();
            lessonInfoMap.put(getInstructor.getInstructorId(), new LessonScheduleVO(getInstructor));
            reserveScheduleMap.put(getInstructor.getInstructorId(), new ArrayList<>());
        }

        for (ReserveScheduleVO reserveScheduleVO : reserveScheduleVOs) {
            if (reserveScheduleVO.getIsDesignated() && reserveScheduleVO.getInstructorId() != null) {
                if (!assignInstructorLessons(reserveScheduleVO.getInstructorId(), reserveScheduleVO, lessonInfoMap, reserveScheduleMap))
                    return null;
            }
        }
        if (assignTeamLessons(reserveScheduleVOs, lessonInfoMap, reserveScheduleMap)) {
            return reserveScheduleMap;
        }
        return null;
    }

    // 강사 지정수업 배정하기
    private boolean assignInstructorLessons(Integer instructorId, ReserveScheduleVO reserveScheduleVO,
                                            Map<Integer, LessonScheduleVO> lessonInfoMap,
                                            Map<Integer, List<ReserveScheduleVO>> reserveScheduleMap) {
        LessonScheduleVO lessonScheduleVO = lessonInfoMap.get(instructorId);
        if (lessonScheduleVO == null) return false; // 이 팀에 존재하지 않는 강사

        return canAssignLesson(lessonScheduleVO, lessonInfoMap, reserveScheduleVO, reserveScheduleMap);
    }

    // 팀 수업 배정하기
    private boolean assignTeamLessons(List<ReserveScheduleVO> reserveScheduleVOs,
                                      Map<Integer, LessonScheduleVO> lessonInfoMap,
                                      Map<Integer, List<ReserveScheduleVO>> reserveScheduleMap) {
        // 시간이 제일 적은 사람 순, 강의 끝나는 시간이 빠른 긴 순으로
        TreeSet<LessonScheduleVO> lessonInfoTreeSet = new TreeSet<>(
                Comparator.comparingInt(LessonScheduleVO::getTotalTime)
                        .thenComparing(LessonScheduleVO::getInstructorId)
        );

        lessonInfoTreeSet.addAll(lessonInfoMap.values());
        reserveScheduleVOs.sort((Comparator.comparingInt(o -> Integer.parseInt(o.getStartTime()) + o.getDuration() * 100)));

        teamLesson:
        for (ReserveScheduleVO reserveScheduleVO : reserveScheduleVOs) {
            if (!reserveScheduleVO.getIsDesignated() || reserveScheduleVO.getInstructorId() == null) {
                for (LessonScheduleVO lessonScheduleVO : lessonInfoTreeSet) {
                    if (canAssignLesson(lessonScheduleVO, lessonInfoMap, reserveScheduleVO, reserveScheduleMap)) {
                        continue teamLesson;
                    }
                }
                return false; // 모든 강사가 수업이 불가능함
            }
        }
        return true;
    }

    private boolean canAssignLesson(LessonScheduleVO lessonScheduleVO, Map<Integer, LessonScheduleVO> lessonInfoMap,
                                    ReserveScheduleVO reserveScheduleVO, Map<Integer, List<ReserveScheduleVO>> reserveScheduleMap) {
        // 기술 체크
        if (!reserveScheduleVO.getLessonType().equals("1000000")
                && !((Integer.parseInt(reserveScheduleVO.getLessonType(), 2)
                & Integer.parseInt(lessonScheduleVO.getIsInstructAvailable(), 2))
                == Integer.parseInt(reserveScheduleVO.getLessonType(), 2))
        ) return false; // 강의가 불가능한 강사

        // 시간 체크
        long lessonTime = calculateLessonTime(Integer.parseInt(reserveScheduleVO.getStartTime()), reserveScheduleVO.getDuration());
        if ((lessonScheduleVO.getTimeTable() & lessonTime) == 0) {
            // 기존 타임테이블과 겹치지 않으면 추가한다
            lessonScheduleVO.setTimeTable(lessonScheduleVO.getTimeTable() | lessonTime);
            lessonScheduleVO.setTotalTime(lessonScheduleVO.getTotalTime() + reserveScheduleVO.getDuration());
            reserveScheduleVO.setInstructorId(lessonScheduleVO.getInstructorId());
            reserveScheduleMap.get(lessonScheduleVO.getInstructorId()).add(reserveScheduleVO);

            lessonInfoMap.remove(lessonScheduleVO.getInstructorId());
            lessonInfoMap.put(lessonScheduleVO.getInstructorId(), lessonScheduleVO);
            return true;
        }
        return false;
    }

    private long calculateLessonTime(int startTime, int duration) {
        long lessonTime = 0;
        startTime = startTime / 50 + startTime % 100 / 30;
        for (int i = 0; i < duration * 2; i++) {
            lessonTime = lessonTime << 1;
            lessonTime++;
        }
        return lessonTime << startTime;
    }

    // 매일 자정에 실행되는 스케줄러
    @Scheduled(cron = "0 0 18 * * ?")
    @Transactional
    public void updateDatabase() {
        // instructorId가 null인 데이터에 대해 업데이트
        log.info("팀 강습 강사 배정 - 날짜: {}", LocalDate.now().plusDays(1).format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        Set<String> keys = redisTemplate.keys("scheduleCache:*:*:" + LocalDate.now().plusDays(1).format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        if (keys != null && !keys.isEmpty()) {
            for (String key : keys) {
                Optional<ScheduleCacheDto> scheduleCacheDto = scheduleCacheRepository.findById(key.substring(14));
                if (scheduleCacheDto.isPresent()) {
                    List<ReserveScheduleVO> reserveScheduleVOs = scheduleCacheDto.get().getReserveScheduleVOs();
                    if (reserveScheduleVOs != null && !reserveScheduleVOs.isEmpty()) {
                        for (ReserveScheduleVO reserveScheduleVO : reserveScheduleVOs) {
                            Optional<Lesson> lesson = lessonRepository.findById(reserveScheduleVO.getLessonId());
                            if (lesson.isPresent() && lesson.get().getInstructor() == null) {
                                log.info("{}번 강습 {}번 강사에게 배정", reserveScheduleVO.getLessonId(), reserveScheduleVO.getInstructorId());
                                lessonRepository.updateInstructorId(reserveScheduleVO.getInstructorId(), reserveScheduleVO.getLessonId());
                                eventPublisher.publishDesignatedEvent(reserveScheduleVO.getInstructorId(), reserveScheduleVO.getLessonId());
                            }
                        }
                    }
                }
            }
        }
    }

    @Scheduled(cron = "0 1 18 * * ?")
    public void updateSchedule() {
        // instructorId가 null인 데이터에 대해 업데이트
        log.info("스케쥴 업데이트 - 날짜: {}", LocalDate.now().plusDays(1).format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        Set<String> keys = redisTemplate.keys("scheduleCache:*:*:" + LocalDate.now().plusDays(1).format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        if (keys != null && !keys.isEmpty()) {
            for (String key : keys) {
                Optional<ScheduleCacheDto> scheduleCacheDto = scheduleCacheRepository.findById(key.substring(14));
                if (scheduleCacheDto.isPresent()) {
                    List<ReserveScheduleVO> reserveScheduleVOs = scheduleCacheDto.get().getReserveScheduleVOs();
                    if (reserveScheduleVOs != null && !reserveScheduleVOs.isEmpty()) {
                        String[] parts = key.split(":");
                        Integer teamId = Integer.parseInt(parts[2]);
                        LocalDate lessonDate = LocalDate.parse(parts[3]);
                        Team team = Team.builder().teamId(teamId).build();
                        log.info("{}번 팀 스케쥴 캐싱하기", teamId);
                        scheduleCaching(team, lessonDate);
                    }
                }
            }
        }
    }
}
