package com.go.ski.schedule.support.vo;

import com.go.ski.lesson.support.vo.ReserveInfoVO;
import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.model.LessonInfo;
import com.go.ski.payment.core.model.LessonPaymentInfo;
import com.go.ski.payment.core.model.StudentInfo;
import com.go.ski.payment.support.dto.util.StudentInfoDTO;
import com.go.ski.redis.dto.PaymentCacheDto;
import com.go.ski.team.core.model.Team;
import com.go.ski.user.core.model.Instructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

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
    private Boolean isDesignated;
    @Setter
    private Integer instructorId;

    public ReserveScheduleVO(PaymentCacheDto paymentCacheDto) {
        super(paymentCacheDto);
        Lesson lesson = paymentCacheDto.getLesson();
        Team team = lesson.getTeam();

        lessonId = lesson.getLessonId();
        teamId = team.getTeamId();
        teamName = team.getTeamName();
        resortName = team.getSkiResort().getResortName();
        studentInfoDTOs = paymentCacheDto.getStudentInfos();
        representativeName = lesson.getRepresentativeName();
        isDesignated = paymentCacheDto.getLessonPaymentInfo().getDesignatedFee() != null;
        instructorId = lesson.getInstructor() != null ? lesson.getInstructor().getInstructorId() : null;
    }

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
        isDesignated = lessonPaymentInfo.getDesignatedFee() != null;
        instructorId = lesson.getInstructor() != null ? lesson.getInstructor().getInstructorId() : null;
    }
}
