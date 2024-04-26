package com.go.ski.lesson.core.service;

import com.go.ski.lesson.support.dto.ReserveAdvancedRequestDTO;
import com.go.ski.lesson.support.dto.ReserveNoviceRequestDTO;
import com.go.ski.lesson.support.dto.ReserveNoviceResponseDTO;
import com.go.ski.lesson.support.vo.LessonScheduleVO;
import com.go.ski.payment.core.model.LessonInfo;
import com.go.ski.payment.core.repository.LessonInfoRepository;
import com.go.ski.payment.support.vo.LessonType;
import com.go.ski.team.core.model.SkiResort;
import com.go.ski.team.core.model.Team;
import com.go.ski.team.core.model.TeamImage;
import com.go.ski.team.core.model.TeamInstructor;
import com.go.ski.team.core.repository.TeamImageRepository;
import com.go.ski.team.core.repository.TeamInstructorRepository;
import com.go.ski.team.core.repository.TeamRepository;
import com.go.ski.team.support.vo.TeamImageVO;
import com.go.ski.user.core.model.Instructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class LessonService {
    private final TeamRepository teamRepository;
    private final LessonInfoRepository lessonInfoRepository;
    private final TeamInstructorRepository teamInstructorRepository;
    private final TeamImageRepository teamImageRepository;

    public List<ReserveNoviceResponseDTO> reserveNovice(ReserveAdvancedRequestDTO reserveAdvancedRequestDTO) {
        log.info("resortId로 해당 리조트에 속한 team 리스트 가져오기");
        List<Team> teams = teamRepository.findBySkiResort(SkiResort.builder().resortId(reserveAdvancedRequestDTO.getResortId()).build());
        List<ReserveNoviceResponseDTO> reserveNoviceResponseDTOs = new ArrayList<>();

        for (Team team : teams) {
            ReserveNoviceResponseDTO reserveNoviceResponseDTO = assignLessonsToTeam(team, reserveAdvancedRequestDTO);
            if (reserveNoviceResponseDTO != null) {
                reserveNoviceResponseDTOs.add(reserveNoviceResponseDTO);
                log.info("성공! {}", reserveNoviceResponseDTO);
            } else {
                log.info("해당 팀에 가능한 강사 없음: {}", team);
            }
        }

        return reserveNoviceResponseDTOs;
    }

    public List<Integer> reserveAdvanced(ReserveAdvancedRequestDTO reserveAdvancedRequestDTO) {
        log.info("resortId로 해당 리조트에 속한 team 리스트 가져오기");
        List<Team> teams = teamRepository.findBySkiResort(SkiResort.builder().resortId(reserveAdvancedRequestDTO.getResortId()).build());
        List<Integer> instructorsList = new ArrayList<>();

        for (Team team : teams) {
            ReserveNoviceResponseDTO reserveNoviceResponseDTO = assignLessonsToTeam(team, reserveAdvancedRequestDTO);
            if (reserveNoviceResponseDTO != null) {
                instructorsList.addAll(reserveNoviceResponseDTO.getInstructors());
                log.info("성공! {}", instructorsList);
            } else {
                log.info("해당 팀에 가능한 강사 없음: {}", team);
            }
        }

        return instructorsList;
    }

    private ReserveNoviceResponseDTO assignLessonsToTeam(Team team, ReserveAdvancedRequestDTO reserveAdvancedRequestDTO) {
        // 강습 일자, 팀으로 이미 예약된 강습 리스트
        List<LessonInfo> lessonInfos = lessonInfoRepository.findByLessonDateAndLessonTeam(reserveAdvancedRequestDTO.getLessonDate(), team);
        // 해당 팀에 소속된 강사 리스트
        List<TeamInstructor> teamInstructors = teamInstructorRepository.findByTeamAndIsInviteAccepted(team, true);

        List<Integer> instructors = new ArrayList<>();
        for (TeamInstructor teamInstructor : teamInstructors) {
            Instructor instructor = teamInstructor.getInstructor();
            if (assignLessonsToInstructor(instructor, reserveAdvancedRequestDTO, lessonInfos, teamInstructors))
                instructors.add(instructor.getInstructorId());
        }

        return !instructors.isEmpty() ? new ReserveNoviceResponseDTO(team, instructors, getTeamImage(team)) : null;
    }

    private boolean assignLessonsToInstructor(Instructor instructor, ReserveAdvancedRequestDTO reserveAdvancedRequestDTO,
                                  List<LessonInfo> lessonInfos, List<TeamInstructor> teamInstructors) {
        // 팀에 소속된 강사들 스케줄 맵 만들기
        Map<Integer, LessonScheduleVO> lessonInfoMap = new HashMap<>();
        for (TeamInstructor teamInstructor : teamInstructors) {
            Instructor getInstructor = teamInstructor.getInstructor();
            lessonInfoMap.put(getInstructor.getInstructorId(), new LessonScheduleVO(getInstructor));
        }
        // 리스트에 새로운 강습 추가하기
        LessonInfo newLessonInfo = new LessonInfo(instructor, reserveAdvancedRequestDTO);
        lessonInfos.add(newLessonInfo);

        try {
            // 지정 수업 배정하기
            for (LessonInfo lessonInfo : lessonInfos) {
                if (lessonInfo.getLesson() != null && lessonInfo.getLesson().getInstructor() != null) {
                    if (!assignInstructorLessons(lessonInfo.getLesson().getInstructor(), lessonInfo, lessonInfoMap))
                        return false;
                }
            }
            // 팀 수업 배정하기
            return assignTeamLessons(lessonInfos, lessonInfoMap);
        } finally {
            // 마지막에 추가했던 강습을 제거해야함
            lessonInfos.remove(newLessonInfo);
        }
    }

    private boolean assignInstructorLessons(Instructor instructor, LessonInfo lessonInfo, Map<Integer, LessonScheduleVO> lessonInfoMap) {
        LessonScheduleVO lessonScheduleVO = lessonInfoMap.get(instructor.getInstructorId());
        if (lessonScheduleVO == null) return false; // 이 팀에 존재하지 않는 강사

        return canAssignLesson(lessonScheduleVO, lessonInfo);
    }

    private boolean assignTeamLessons(List<LessonInfo> lessonInfos, Map<Integer, LessonScheduleVO> lessonInfoMap) {
        // 시간이 제일 적은 사람 순, 강의 끝나는 시간이 빠른 긴 순으로
        TreeSet<LessonScheduleVO> lessonInfoTreeSet = new TreeSet<>(Comparator.comparingInt(LessonScheduleVO::getTotalTime));
        lessonInfoTreeSet.addAll(lessonInfoMap.values());
        lessonInfos.sort((Comparator.comparingInt(o -> Integer.parseInt(o.getStartTime()) + o.getDuration() * 100)));

        teamLesson:
        for (LessonInfo lessonInfo : lessonInfos) {
            if (lessonInfo.getLesson() == null || lessonInfo.getLesson().getInstructor() == null) {
                for (LessonScheduleVO lessonScheduleVO : lessonInfoTreeSet) {
                    if (canAssignLesson(lessonScheduleVO, lessonInfo)) {
                        continue teamLesson;
                    }
                }
                return false; // 모든 강사가 수업이 불가능함
            }
        }
        return true;
    }

    private boolean canAssignLesson(LessonScheduleVO lessonScheduleVO, LessonInfo lessonInfo) {
        // 기술 체크
        if (!lessonInfo.getLessonType().equals(LessonType.DAYOFF)
                 &&
                !lessonScheduleVO.getIsInstructAvailable().toString().equals(lessonInfo.getLessonType().toString())
        ) return false; // 강의가 불가능한 강사
        // lessonType이 dayoff면 무조건 가능
        // 그 외는 강사의 가능 여부와 강의를 비교
        Integer.toBinaryString(Integer.parseInt(lessonScheduleVO.getIsInstructAvailable()));


        // 시간 체크
        long lessonTime = calculateLessonTime(Integer.parseInt(lessonInfo.getStartTime()), lessonInfo.getDuration());
        if ((lessonScheduleVO.getTimeTable() & lessonTime) == 0) {
            // 기존 타임테이블과 겹치지 않으면 추가한다
            lessonScheduleVO.setTimeTable(lessonScheduleVO.getTimeTable() | calculateLessonTime(Integer.parseInt(lessonInfo.getStartTime()), lessonInfo.getDuration()));
            lessonScheduleVO.setTotalTime(lessonScheduleVO.getTotalTime() + lessonInfo.getDuration());
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

    private List<TeamImageVO> getTeamImage(Team team) {
        List<TeamImage> teamImages = teamImageRepository.findByTeam(team);
        List<TeamImageVO> teamImageVOs = new ArrayList<>();
        for (TeamImage teamImage : teamImages) {
            teamImageVOs.add(TeamImageVO.toVO(teamImage));
        }
        return teamImageVOs;
    }

}
