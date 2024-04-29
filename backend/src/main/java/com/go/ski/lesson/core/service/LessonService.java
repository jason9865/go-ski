package com.go.ski.lesson.core.service;

import com.go.ski.lesson.support.dto.ReserveAdvancedResponseDTO;
import com.go.ski.lesson.support.dto.ReserveNoviceResponseDTO;
import com.go.ski.lesson.support.dto.ReserveNoviceTeamRequestDTO;
import com.go.ski.lesson.support.vo.CertificateInfoVO;
import com.go.ski.lesson.support.vo.LessonScheduleVO;
import com.go.ski.lesson.support.vo.ReserveInfoVO;
import com.go.ski.payment.core.model.LessonInfo;
import com.go.ski.payment.core.repository.LessonInfoRepository;
import com.go.ski.review.core.model.Review;
import com.go.ski.review.core.repository.ReviewRepository;
import com.go.ski.team.core.model.*;
import com.go.ski.team.core.repository.*;
import com.go.ski.team.support.vo.TeamImageVO;
import com.go.ski.user.core.model.Certificate;
import com.go.ski.user.core.model.Instructor;
import com.go.ski.user.core.model.InstructorCert;
import com.go.ski.user.core.model.User;
import com.go.ski.user.core.repository.InstructorCertRepository;
import com.go.ski.user.core.repository.InstructorRepository;
import com.go.ski.user.core.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class LessonService {
    private final TeamRepository teamRepository;
    private final LessonInfoRepository lessonInfoRepository;
    private final TeamInstructorRepository teamInstructorRepository;
    private final TeamImageRepository teamImageRepository;
    private final OneToNOptionRepository oneToNOptionRepository;
    private final LevelOptionRepository levelOptionRepository;
    private final ReviewRepository reviewRepository;
    private final UserRepository userRepository;
    private final PermissionRepository permissionRepository;
    private final InstructorRepository instructorRepository;
    private final InstructorCertRepository instructorCertRepository;

    public List<ReserveNoviceResponseDTO> getTeamsForNovice(ReserveInfoVO reserveInfoVO) {
        log.info("resortId로 해당 리조트에 속한 team 리스트 가져오기");
        List<Team> teams = teamRepository.findBySkiResort(SkiResort.builder().resortId(reserveInfoVO.getResortId()).build());
        List<ReserveNoviceResponseDTO> reserveNoviceResponseDTOs = new ArrayList<>();

        for (Team team : teams) {
            ReserveNoviceResponseDTO reserveNoviceResponseDTO = assignLessonsToTeam(team, reserveInfoVO);
            if (reserveNoviceResponseDTO != null) {
                // 팀 가격 설정
                if (reserveInfoVO.getStudentCount() > 0) {
                    Optional<OneToNOption> oneToNOption = oneToNOptionRepository.findById(team.getTeamId());
                    int teamCost = calculateTeamCost(team.getTeamCost(), oneToNOption, reserveInfoVO.getStudentCount());
                    reserveNoviceResponseDTO.setTeamCost(teamCost * reserveInfoVO.getDuration());
                }
                // 별점 설정
                List<Review> reviews = reviewRepository.findByLessonTeam(team);
                if (!reviews.isEmpty()) {
                    double rating = 0;
                    for (Review review : reviews)
                        rating += review.getRating();
                    reserveNoviceResponseDTO.setRating(rating / reviews.size());
                    reserveNoviceResponseDTO.setRatingCount(reviews.size());
                }
                log.info("성공! {}", reserveNoviceResponseDTO);
                reserveNoviceResponseDTOs.add(reserveNoviceResponseDTO);
            } else {
                log.info("해당 팀에 가능한 강사 없음: {}", team);
            }
        }

        return reserveNoviceResponseDTOs;
    }

    public Map<Integer, List<Integer>> getInstructorsForAdvanced(ReserveInfoVO reserveInfoVO) {
        log.info("resortId로 해당 리조트에 속한 team 리스트 가져오기");
        List<Team> teams = teamRepository.findBySkiResort(SkiResort.builder().resortId(reserveInfoVO.getResortId()).build());
        Map<Integer, List<Integer>> teamInstructorMap = new HashMap<>();

        for (Team team : teams) {
            ReserveNoviceResponseDTO reserveNoviceResponseDTO = assignLessonsToTeam(team, reserveInfoVO);
            if (reserveNoviceResponseDTO != null) {
                log.info("성공! {}", reserveNoviceResponseDTO);
                teamInstructorMap.put(reserveNoviceResponseDTO.getTeamId(), reserveNoviceResponseDTO.getInstructors());
            } else {
                log.info("해당 팀에 가능한 강사 없음: {}", team);
            }
        }

        return teamInstructorMap;
    }

    public List<ReserveAdvancedResponseDTO> getInstructorsInTeam(int teamId, ReserveNoviceTeamRequestDTO reserveNoviceTeamRequestDTO) {
        List<ReserveAdvancedResponseDTO> reserveAdvancedResponseDTOs = new ArrayList<>();
        List<Integer> instructorsList = reserveNoviceTeamRequestDTO.getInstructorsList();
        for (int instructorId : instructorsList) {
            try {
                User user = userRepository.findById(instructorId).orElseThrow();
                Instructor instructor = instructorRepository.findById(instructorId).orElseThrow();
                Team team = teamRepository.findById(teamId).orElseThrow();
                TeamInstructor teamInstructor = teamInstructorRepository.findByTeamAndInstructor(team, instructor).orElseThrow();
                Permission permission = permissionRepository.findById(teamInstructor.getTeamInstructorId()).orElseThrow();
                List<CertificateInfoVO> certificateInfoVOs = instructorCertRepository.findByInstructor(instructor)
                        .stream().map(this::getCertificateInfoVO).collect(Collectors.toList());

                ReserveAdvancedResponseDTO reserveAdvancedResponseDTO = new ReserveAdvancedResponseDTO(user, instructor, permission, certificateInfoVOs);
                // 가격 설정
                if (reserveNoviceTeamRequestDTO.getStudentCount() > 0) {
                    Optional<OneToNOption> optionalOneToNOption = oneToNOptionRepository.findById(teamId);
                    int teamCost = calculateTeamCost(team.getTeamCost(), optionalOneToNOption, reserveNoviceTeamRequestDTO.getStudentCount());
                    Optional<LevelOption> optionalLevelOption = levelOptionRepository.findById(teamId);
                    int levelCost = calculateLevelCost(optionalLevelOption, reserveNoviceTeamRequestDTO.getLevel());
                    reserveAdvancedResponseDTO.setCost((teamCost + levelCost + permission.getDesignatedCost()) * reserveNoviceTeamRequestDTO.getDuration());
                }
                // 별점 설정
                List<Review> reviews = reviewRepository.findByLessonInstructor(instructor);
                if (!reviews.isEmpty()) {
                    double rating = 0;
                    for (Review review : reviews)
                        rating += review.getRating();
                    reserveAdvancedResponseDTO.setRating(rating / reviews.size());
                    reserveAdvancedResponseDTO.setRatingCount(reviews.size());
                }
                reserveAdvancedResponseDTOs.add(reserveAdvancedResponseDTO);
            } catch (NoSuchElementException ignored) {
            }
        }
        return reserveAdvancedResponseDTOs;
    }

    private CertificateInfoVO getCertificateInfoVO(InstructorCert instructorCert) {
        CertificateInfoVO certificateInfoVO = new CertificateInfoVO();
        Certificate certificate = instructorCert.getCertificate();
        certificateInfoVO.setCertificateId(certificate.getCertificateId());
        certificateInfoVO.setCertificateName(certificate.getCertificateName());
        certificateInfoVO.setCertificateType(certificate.getCertificateType());
        certificateInfoVO.setCertificateImageUrl(instructorCert.getCertificateImageUrl());
        return certificateInfoVO;
    }

    private ReserveNoviceResponseDTO assignLessonsToTeam(Team team, ReserveInfoVO reserveInfoVO) {
        // 강습 일자, 팀으로 이미 예약된 강습 리스트
        List<LessonInfo> lessonInfos = lessonInfoRepository.findByLessonDateAndLessonTeam(reserveInfoVO.getLessonDate(), team);
        // 해당 팀에 소속된 강사 리스트
        List<TeamInstructor> teamInstructors = teamInstructorRepository.findByTeamAndIsInviteAccepted(team, true);

        List<Integer> instructors = new ArrayList<>();
        for (TeamInstructor teamInstructor : teamInstructors) {
            Instructor instructor = teamInstructor.getInstructor();
            if (assignLessonsToInstructor(instructor, reserveInfoVO, lessonInfos, teamInstructors))
                instructors.add(instructor.getInstructorId());
        }

        return !instructors.isEmpty() ? new ReserveNoviceResponseDTO(team, instructors, getTeamImage(team)) : null;
    }

    private boolean assignLessonsToInstructor(Instructor instructor, ReserveInfoVO reserveInfoVO,
                                              List<LessonInfo> lessonInfos, List<TeamInstructor> teamInstructors) {
        // 팀에 소속된 강사들 스케줄 맵 만들기
        Map<Integer, LessonScheduleVO> lessonInfoMap = new HashMap<>();
        for (TeamInstructor teamInstructor : teamInstructors) {
            Instructor getInstructor = teamInstructor.getInstructor();
            lessonInfoMap.put(getInstructor.getInstructorId(), new LessonScheduleVO(getInstructor));
        }
        // 리스트에 새로운 강습 추가하기
        LessonInfo newLessonInfo = new LessonInfo(instructor, reserveInfoVO);
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
        if (!lessonInfo.getLessonType().equals("1000000")
                && !((Integer.parseInt(lessonInfo.getLessonType(), 2)
                & Integer.parseInt(lessonScheduleVO.getIsInstructAvailable(), 2))
                == Integer.parseInt(lessonInfo.getLessonType(), 2))
        ) return false; // 강의가 불가능한 강사

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

    private int calculateTeamCost(int teamCost, Optional<OneToNOption> optionalOneToNOption, int studentCount) {
        return optionalOneToNOption.map(option -> switch (studentCount) {
            case 1 -> teamCost;
            case 2 -> teamCost + option.getOneTwoFee();
            case 3 -> teamCost + option.getOneThreeFee();
            case 4 -> teamCost + option.getOneFourFee();
            default -> teamCost + option.getOneNFee();
        }).orElse(teamCost);
    }

    private int calculateLevelCost(Optional<LevelOption> optionalLevelOption, String level) {
        return optionalLevelOption.map(option -> switch (level) {
            case "중급" -> option.getIntermediateFee();
            case "고급" -> option.getAdvancedFee();
            default -> 0;
        }).orElse(0);
    }
}
