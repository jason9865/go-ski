package com.go.ski.schedule.core.service;

import com.go.ski.lesson.support.vo.LessonScheduleVO;
import com.go.ski.payment.core.model.LessonInfo;
import com.go.ski.payment.core.model.LessonPaymentInfo;
import com.go.ski.payment.core.repository.LessonInfoRepository;
import com.go.ski.payment.core.repository.LessonPaymentInfoRepository;
import com.go.ski.payment.core.repository.StudentInfoRepository;
import com.go.ski.payment.support.dto.util.StudentInfoDTO;
import com.go.ski.redis.dto.ScheduleCacheDto;
import com.go.ski.redis.repository.ScheduleCacheRepository;
import com.go.ski.schedule.support.vo.ReserveScheduleVO;
import com.go.ski.team.core.model.Team;
import com.go.ski.team.core.model.TeamInstructor;
import com.go.ski.team.core.repository.TeamInstructorRepository;
import com.go.ski.user.core.model.Instructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class ScheduleService {
    private final LessonInfoRepository lessonInfoRepository;
    private final TeamInstructorRepository teamInstructorRepository;
    private final StudentInfoRepository studentInfoRepository;
    private final LessonPaymentInfoRepository lessonPaymentInfoRepository;
    private final ScheduleCacheRepository scheduleCacheRepository;

    public boolean scheduleCaching(Team team, ReserveScheduleVO reserveScheduleVO) {
        // 해당 팀에 소속된 강사 리스트
        List<TeamInstructor> teamInstructors = teamInstructorRepository.findByTeamAndIsInviteAccepted(team, true);
        // 강습 일자, 팀으로 이미 예약된 강습 리스트
        List<LessonInfo> lessonInfos = lessonInfoRepository.findByLessonDateAndLessonTeam(reserveScheduleVO.getLessonDate(), team);
        // lessonInfo를 ReserveScheduleVO로 변환
        List<ReserveScheduleVO> reserveScheduleVOs = new ArrayList<>();
        for (LessonInfo lessonInfo : lessonInfos) {
            List<StudentInfoDTO> studentInfoDTOs = studentInfoRepository.findByLessonInfo(lessonInfo).stream()
                    .map(StudentInfoDTO::new).toList();
            LessonPaymentInfo lessonPaymentInfo = lessonPaymentInfoRepository.findById(lessonInfo.getLesson().getLessonId()).orElseThrow();
            reserveScheduleVOs.add(new ReserveScheduleVO(lessonInfo, studentInfoDTOs, lessonPaymentInfo));
        }
        reserveScheduleVOs.add(reserveScheduleVO);

        Map<Integer, List<ReserveScheduleVO>> reserveScheduleMap = assignLessons(reserveScheduleVOs, teamInstructors);
        if (reserveScheduleMap != null) {
            // 예약이 가능하면 기존에 저장되어 있던 것들을 지우고 새로 저장해야함
            String id = reserveScheduleVO.getLessonDate() + ":" + team.getTeamId() + ":";
            reserveScheduleMap.forEach((instructorId, ReserveScheduleVOs) ->
                    scheduleCacheRepository.save(new ScheduleCacheDto(id + instructorId, ReserveScheduleVOs, reserveScheduleVO.getLessonDate())));
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
            if (reserveScheduleVO.getIsDesignated() && reserveScheduleVO.getInstructor() != null) {
                if (!assignInstructorLessons(reserveScheduleVO.getInstructor(), reserveScheduleVO, lessonInfoMap, reserveScheduleMap))
                    return null;
            }
        }
        if (assignTeamLessons(reserveScheduleVOs, lessonInfoMap, reserveScheduleMap)) {
            return reserveScheduleMap;
        }
        return null;
    }

    // 강사 지정수업 배정하기
    private boolean assignInstructorLessons(Instructor instructor, ReserveScheduleVO reserveScheduleVO,
                                            Map<Integer, LessonScheduleVO> lessonInfoMap,
                                            Map<Integer, List<ReserveScheduleVO>> reserveScheduleMap) {
        LessonScheduleVO lessonScheduleVO = lessonInfoMap.get(instructor.getInstructorId());
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
            if (!reserveScheduleVO.getIsDesignated() || reserveScheduleVO.getInstructor() == null) {
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
            lessonScheduleVO.setTimeTable(lessonScheduleVO.getTimeTable() | calculateLessonTime(Integer.parseInt(reserveScheduleVO.getStartTime()), reserveScheduleVO.getDuration()));
            lessonScheduleVO.setTotalTime(lessonScheduleVO.getTotalTime() + reserveScheduleVO.getDuration());
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

}
