package com.go.ski.schedule.support.vo;

import com.go.ski.lesson.support.vo.ReserveInfoVO;
import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.model.LessonInfo;
import com.go.ski.payment.core.model.LessonPaymentInfo;
import com.go.ski.payment.support.dto.util.StudentInfoDTO;
import com.go.ski.schedule.support.dto.CreateScheduleRequestDTO;
import com.go.ski.team.core.model.SkiResort;
import com.go.ski.team.core.model.Team;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

@Getter
@NoArgsConstructor
@ToString
public class ReserveScheduleVO extends ReserveInfoVO {
    private Integer lessonId;
    private Integer teamId;
    private String teamName;
    private String resortName;
    private List<StudentInfoDTO> studentInfoDTOs;
    private String representativeName;
    private String requestComplain;
    private Boolean isDesignated;
    @Setter
    private Integer instructorId;

    public ReserveScheduleVO(LessonInfo lessonInfo, List<StudentInfoDTO> studentInfoDTOs, LessonPaymentInfo lessonPaymentInfo) {
        super(lessonInfo);
        Lesson lesson = lessonInfo.getLesson();
        Team team = lesson.getTeam();

        lessonId = lesson.getLessonId();
        teamId = team.getTeamId();
        teamName = team.getTeamName();
        resortName = team.getSkiResort().getResortName();
        this.studentInfoDTOs = studentInfoDTOs;
        representativeName = lesson.getRepresentativeName();
        instructorId = lesson.getInstructor() != null ? lesson.getInstructor().getInstructorId() : null;
        isDesignated = instructorId != null;
        requestComplain = lessonInfo.getRequestComplain();
    }

    public ReserveScheduleVO(CreateScheduleRequestDTO createScheduleRequestDTO) {
        super(createScheduleRequestDTO);
        teamId = createScheduleRequestDTO.getTeamId();
        instructorId = createScheduleRequestDTO.getInstructorId();
        isDesignated = instructorId != null;
        representativeName = createScheduleRequestDTO.getUserName();
        requestComplain = createScheduleRequestDTO.getContent();
    }

    public ReserveScheduleVO(Integer lessonId, CreateScheduleRequestDTO createScheduleRequestDTO) {
        super(createScheduleRequestDTO);
        this.lessonId = lessonId;
        teamId = createScheduleRequestDTO.getTeamId();
        instructorId = createScheduleRequestDTO.getInstructorId();
        isDesignated = instructorId != null;
        representativeName = createScheduleRequestDTO.getUserName();
        requestComplain = createScheduleRequestDTO.getContent();
    }
}
