package com.go.ski.lesson.core.service;

import com.go.ski.lesson.support.dto.*;
import com.go.ski.lesson.support.vo.CertificateInfoVO;
import com.go.ski.lesson.support.vo.LessonScheduleVO;
import com.go.ski.lesson.support.vo.ReserveInfoVO;
import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.model.LessonInfo;
import com.go.ski.payment.core.model.LessonPaymentInfo;
import com.go.ski.payment.core.model.StudentInfo;
import com.go.ski.payment.core.repository.LessonInfoRepository;
import com.go.ski.payment.core.repository.LessonPaymentInfoRepository;
import com.go.ski.payment.core.repository.LessonRepository;
import com.go.ski.payment.core.repository.StudentInfoRepository;
import com.go.ski.review.core.repository.ReviewRepository;
import com.go.ski.review.support.dto.ReviewResponseDTO;
import com.go.ski.team.core.model.*;
import com.go.ski.team.core.repository.*;
import com.go.ski.team.support.vo.TeamImageVO;
import com.go.ski.user.core.model.Instructor;
import com.go.ski.user.core.model.User;
import com.go.ski.user.core.repository.InstructorCertRepository;
import com.go.ski.user.core.repository.InstructorRepository;
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
    private final PermissionRepository permissionRepository;
    private final InstructorRepository instructorRepository;
    private final InstructorCertRepository instructorCertRepository;
    private final LessonRepository lessonRepository;
    private final StudentInfoRepository studentInfoRepository;
    private final LessonPaymentInfoRepository lessonPaymentInfoRepository;

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
                    int oneToNOptionFee = getOneToNOption(oneToNOption, reserveInfoVO.getStudentCount());
                    int teamCost = oneToNOptionFee + team.getTeamCost();
                    reserveNoviceResponseDTO.setBasicFee(teamCost);
                    reserveNoviceResponseDTO.setPeopleOptionFee(oneToNOptionFee);
                    reserveNoviceResponseDTO.setCost(teamCost * reserveInfoVO.getDuration());
                }
                // 별점 설정
                List<ReviewResponseDTO> reviews = reviewRepository.findByLessonTeam(team).stream().map(ReviewResponseDTO::new).toList();
                setReviewRating(reviews, reserveNoviceResponseDTO);

                reserveNoviceResponseDTOs.add(reserveNoviceResponseDTO);
            } else {
                log.info("해당 팀에 가능한 강사 없음: {}", team);
            }
        }

        return reserveNoviceResponseDTOs;
    }

    public Map<Integer, ReserveNoviceTeamRequestDTO> getInstructorsForAdvanced(ReserveInfoVO reserveInfoVO) {
        log.info("resortId로 해당 리조트에 속한 team 리스트 가져오기");
        List<Team> teams = teamRepository.findBySkiResort(SkiResort.builder().resortId(reserveInfoVO.getResortId()).build());
        Map<Integer, ReserveNoviceTeamRequestDTO> teamInstructorMap = new HashMap<>();

        for (Team team : teams) {
            ReserveNoviceResponseDTO reserveNoviceResponseDTO = assignLessonsToTeam(team, reserveInfoVO);
            if (reserveNoviceResponseDTO != null) {
                ReserveNoviceTeamRequestDTO reserveNoviceTeamRequestDTO = new ReserveNoviceTeamRequestDTO(reserveInfoVO);
                reserveNoviceTeamRequestDTO.setInstructorsList(reserveNoviceResponseDTO.getInstructors());
                teamInstructorMap.put(reserveNoviceResponseDTO.getTeamId(), reserveNoviceTeamRequestDTO);
            } else {
                log.info("해당 팀에 가능한 강사 없음: {}", team);
            }
        }

        return teamInstructorMap;
    }

    public List<ReserveAdvancedResponseDTO> getInstructorsInTeam(int teamId, ReserveNoviceTeamRequestDTO reserveNoviceTeamRequestDTO) {
        List<ReserveAdvancedResponseDTO> reserveAdvancedResponseDTOs = new ArrayList<>();
        List<Integer> instructors = reserveNoviceTeamRequestDTO.getInstructorsList();
        Map<Integer, Integer> instructorPositionMap = new HashMap<>();
        for (int instructorId : instructors) {
            Integer teamInstructorId = teamInstructorRepository.findTeamInstructorIdByInstructorIdAndTeamId(instructorId, teamId);
            Permission permission = permissionRepository.findById(teamInstructorId).orElseThrow();
            int tmpPosition = permission.getPosition();
            // instructorId와 tmpPosition을 맵에 저장
            instructorPositionMap.put(instructorId, tmpPosition);
        }

        List<Integer> sortedInstructorsByPosition = instructorPositionMap.entrySet().stream()
            .sorted(Map.Entry.comparingByValue())
            .map(Map.Entry::getKey)
            .toList();

        for (int instructorId : sortedInstructorsByPosition) {
            try {
                Instructor instructor = instructorRepository.findById(instructorId).orElseThrow();
                Team team = teamRepository.findById(teamId).orElseThrow();
                TeamInstructor teamInstructor = teamInstructorRepository.findByTeamAndInstructor(team, instructor).orElseThrow();
                Permission permission = permissionRepository.findById(teamInstructor.getTeamInstructorId()).orElseThrow();
                List<CertificateInfoVO> certificateInfoVOs = instructorCertRepository.findByInstructor(instructor)
                        .stream().map(CertificateInfoVO::new).collect(Collectors.toList());

                ReserveAdvancedResponseDTO reserveAdvancedResponseDTO = new ReserveAdvancedResponseDTO(instructor, permission, certificateInfoVOs);
                // 가격 설정
                if (reserveNoviceTeamRequestDTO.getStudentCount() > 0) {
                    Optional<OneToNOption> optionalOneToNOption = oneToNOptionRepository.findById(teamId);
                    int teamCost = calculateTeamCost(team.getTeamCost(), optionalOneToNOption, reserveNoviceTeamRequestDTO.getStudentCount());
                    Optional<LevelOption> optionalLevelOption = levelOptionRepository.findById(teamId);
                    int levelCost = calculateLevelCost(optionalLevelOption, reserveNoviceTeamRequestDTO.getLevel());
                    Optional<OneToNOption> oneToNOption = oneToNOptionRepository.findById(team.getTeamId());
                    int oneToNOptionFee = getOneToNOption(oneToNOption, reserveNoviceTeamRequestDTO.getStudentCount());

                    reserveAdvancedResponseDTO.setCost(teamCost * reserveNoviceTeamRequestDTO.getDuration());
                    reserveAdvancedResponseDTO.setBasicFee(teamCost);
                    reserveAdvancedResponseDTO.setPeopleOptionFee(oneToNOptionFee);
                    reserveAdvancedResponseDTO.setDesignatedFee(permission.getDesignatedCost() * reserveNoviceTeamRequestDTO.getDuration());
                    reserveAdvancedResponseDTO.setLevelOptionFee(levelCost * reserveNoviceTeamRequestDTO.getDuration());
                }
                // 별점 설정
                List<ReviewResponseDTO> reviews = reviewRepository.findByLessonInstructor(instructor).stream().map(ReviewResponseDTO::new).toList();
                setReviewRating(reviews, reserveAdvancedResponseDTO);

                reserveAdvancedResponseDTOs.add(reserveAdvancedResponseDTO);
            } catch (NoSuchElementException ignored) {
            }
        }
        return reserveAdvancedResponseDTOs;
    }

    public List<UserLessonResponseDTO> getUserLessonList(User user) {
        List<UserLessonResponseDTO> userLessonResponseDTOs = new ArrayList<>();
        for (Lesson lesson : lessonRepository.findByUser(user)) {
            try {
                LessonInfo lessonInfo = lessonInfoRepository.findById(lesson.getLessonId()).orElseThrow();
                Boolean hasReview = Boolean.TRUE;
                if (reviewRepository.findByLesson(lesson).isEmpty()) hasReview = Boolean.FALSE;
                userLessonResponseDTOs.add(new UserLessonResponseDTO(lesson, lessonInfo, hasReview));
            } catch (NoSuchElementException ignored) {
            }
        }
        return userLessonResponseDTOs;
    }

    public List<InstructorLessonResponseDTO> getInstructorLessonList(User user) {
        Instructor instructor = instructorRepository.findById(user.getUserId()).orElseThrow();
        List<Lesson> lessons = lessonRepository.findByInstructor(instructor);
        return getInstructorLessonResponseDTOs(lessons);
    }

    public boolean isNotTeamBoss(User user, int teamId) {
        return !user.equals(teamRepository.findById(teamId).orElse(Team.builder().build()).getUser());
    }

    public List<InstructorLessonResponseDTO> getBossLessonList(int teamId) {
        List<Lesson> lessons = lessonRepository.findByTeamTeamId(teamId);
        return getInstructorLessonResponseDTOs(lessons);
    }

    public List<InstructorLessonResponseDTO> getBossInstructorLessonList(int teamId, int instructorId) {
        List<Lesson> lessons = lessonRepository.findByTeamTeamIdAndInstructorInstructorId(teamId, instructorId);
        return getInstructorLessonResponseDTOs(lessons);
    }

    private List<InstructorLessonResponseDTO> getInstructorLessonResponseDTOs(List<Lesson> lessons) {
        List<InstructorLessonResponseDTO> instructorLessonResponseDTOs = new ArrayList<>();
        for (Lesson lesson : lessons) {
            try {
                LessonInfo lessonInfo = lessonInfoRepository.findById(lesson.getLessonId()).orElseThrow();
                List<StudentInfo> studentInfos = studentInfoRepository.findByLessonInfo(lessonInfo);
                boolean isDesignated = lessonPaymentInfoRepository.findById(lesson.getLessonId())
                        .map(LessonPaymentInfo::getDesignatedFee).isPresent();
                instructorLessonResponseDTOs.add(new InstructorLessonResponseDTO(lesson, lessonInfo, studentInfos, isDesignated));
            } catch (NoSuchElementException ignored) {
            }
        }
        return instructorLessonResponseDTOs;
    }

    // 특정 팀에 예약을 배정할 수 있는 지 판단하는 메서드
    public ReserveNoviceResponseDTO assignLessonsToTeam(Team team, ReserveInfoVO reserveInfoVO) {
        // 강습 일자, 팀으로 이미 예약된 강습 리스트
        List<LessonInfo> lessonInfos = lessonInfoRepository.findByLessonDateAndLessonTeamAndLessonStatus(reserveInfoVO.getLessonDate(), team, 0);
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

    // 특정 강사에게 예약을 배정할 수 있는 지 판단하는 메서드
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
            for (LessonInfo lessonInfo : lessonInfos) {
                if (lessonInfo.getLesson() != null && lessonInfo.getLesson().getInstructor() != null) {
                    if (!assignInstructorLessons(lessonInfo.getLesson().getInstructor(), lessonInfo, lessonInfoMap))
                        return false;
                }
            }
            return assignTeamLessons(lessonInfos, lessonInfoMap);
        } finally {
            // 마지막에 추가했던 강습을 제거해야함
            lessonInfos.remove(newLessonInfo);
        }
    }

    // 강사 지정수업 배정하기
    private boolean assignInstructorLessons(Instructor instructor, LessonInfo lessonInfo, Map<Integer, LessonScheduleVO> lessonInfoMap) {
        LessonScheduleVO lessonScheduleVO = lessonInfoMap.get(instructor.getInstructorId());
        if (lessonScheduleVO == null) return false; // 이 팀에 존재하지 않는 강사

        return canAssignLesson(lessonScheduleVO, lessonInfo);
    }

    // 팀 수업 배정하기
    private boolean assignTeamLessons(List<LessonInfo> lessonInfos, Map<Integer, LessonScheduleVO> lessonInfoMap) {
        // 시간이 제일 적은 사람 순, 강의 끝나는 시간이 빠른 긴 순으로
        TreeSet<LessonScheduleVO> lessonInfoTreeSet = new TreeSet<>(
                Comparator.comparingInt(LessonScheduleVO::getTotalTime)
                        .thenComparing(LessonScheduleVO::getInstructorId)
        );
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

    private int getOneToNOption(Optional<OneToNOption> optionalOneToNOption, int studentCount) {
        return optionalOneToNOption.map(option -> switch (studentCount) {
            case 1 -> 0;
            case 2 -> option.getOneTwoFee();
            case 3 -> option.getOneThreeFee();
            case 4 -> option.getOneFourFee();
            default -> option.getOneNFee();
        }).orElse(0);
    }

    private int calculateLevelCost(Optional<LevelOption> optionalLevelOption, String level) {
        return optionalLevelOption.map(option -> switch (level) {
            case "INTERMEDIATE" -> option.getIntermediateFee();
            case "ADVANCED" -> option.getAdvancedFee();
            default -> 0;
        }).orElse(0);
    }

    private void setReviewRating(List<ReviewResponseDTO> reviews, ReserveResponseDTO reserveResponseDTO) {
        if (!reviews.isEmpty()) {
            double rating = 0;
            for (ReviewResponseDTO review : reviews)
                rating += review.getRating();
            reserveResponseDTO.setRating(rating / reviews.size());
            reserveResponseDTO.setReviewCount(reviews.size());
            reserveResponseDTO.setReviews(reviews);
        }
    }
}
