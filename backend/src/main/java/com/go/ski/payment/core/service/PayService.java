package com.go.ski.payment.core.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.model.LessonInfo;
import com.go.ski.payment.core.model.LessonPaymentInfo;
import com.go.ski.payment.core.model.StudentInfo;
import com.go.ski.payment.core.repository.LessonInfoRepository;
import com.go.ski.payment.core.repository.LessonPaymentInfoRepository;
import com.go.ski.payment.core.repository.LessonRepository;
import com.go.ski.payment.support.dto.request.ReserveLessonPaymentRequestDTO;
import com.go.ski.payment.support.dto.response.ReserveLessonPaymentResponseDTO;
import com.go.ski.payment.support.dto.util.StudentInfoDTO;
import com.go.ski.team.core.model.LevelOption;
import com.go.ski.team.core.model.OneToNOption;
import com.go.ski.team.core.model.Permission;
import com.go.ski.team.core.model.Team;
import com.go.ski.team.core.model.TeamInstructor;
import com.go.ski.team.core.repository.LevelOptionRepository;
import com.go.ski.team.core.repository.OneToNOptionRepository;
import com.go.ski.team.core.repository.PermissionRepository;
import com.go.ski.team.core.repository.TeamInstructorRepository;
import com.go.ski.team.core.repository.TeamRepository;
import com.go.ski.user.core.model.Instructor;
import com.go.ski.user.core.model.User;
import com.go.ski.user.core.repository.InstructorRepository;
import com.go.ski.user.core.repository.UserRepository;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class PayService {

	private final TeamRepository teamRepository;
	private final UserRepository userRepository;
	private final InstructorRepository instructorRepository;
	private final LessonRepository lessonRepository;
	private final LessonInfoRepository lessonInfoRepository;
	private final PermissionRepository permissionRepository;
	private final TeamInstructorRepository teamInstructorRepository;
	private final OneToNOptionRepository oneToNOptionRepository;
	private final LevelOptionRepository levelOptionRepository;
	private final LessonPaymentInfoRepository lessonPaymentInfoRepository;

	// 사용자의 요청으로 생성되기 때문에 isOwn이 그냥 자체 서비스임 HttpServletRequest
	@Transactional
	public ReserveLessonPaymentResponseDTO getResponse(
		HttpServletRequest httpServletRequest,
		ReserveLessonPaymentRequestDTO request) {
		//예약자
		User user = (User)httpServletRequest.getAttribute("user");
		Team team = teamRepository.getReferenceById(request.getTeamId());
		Instructor instructor = instructorRepository.findById(request.getInstId()).orElse(null);

		int size = request.getStudentInfo().size();
		int level = request.getLevel();
		// 레슨 생성
		Lesson lesson = Lesson.toLessonForPayment(user, team, instructor, 0);
		Lesson tmpLesson = lessonRepository.save(lesson);
		// 레슨 아이디 뽑기
		Integer lessonId = tmpLesson.getLessonId();

		LessonInfo lessonInfo = LessonInfo.toLessonForPayment(tmpLesson, request);
		LessonInfo tmpLessonInfo = lessonInfoRepository.save(lessonInfo);

		//사용자 정보 입력
		for(StudentInfoDTO dto : request.getStudentInfo()) {
			StudentInfo studentInfo = StudentInfo.builder()
				.lessonInfo(tmpLessonInfo)
				.height(dto.getHeight())//안되면 Enum 갈아야함
				.weight(dto.getWeight())
				.footSize(dto.getFootSize())
				.age(dto.getAge())
				.gender(dto.getGender())
				.name(dto.getName())
				.build();
		}

		// 2번 생성된 예약정보를 바탕으로 kakaoPayService에 필요한 변수를 넣기
		Integer basicFee = team.getTeamCost();
		Integer designatedFee = 0;//지정 강사 추가금
		Integer peopleOptionFee = 0;//인원 옵션 추가금
		Integer levelOptionFee = 0;//레벨 옵션 추가금
		//팀 예약이면 instructor가 null임
		if(instructor != null) {
			TeamInstructor teamInstructor = teamInstructorRepository
				.findByTeamAndInstructor(team, instructor)
				.orElseThrow();// 여기서 넣을 Exception 생각하기
			Permission permission = permissionRepository
				.findById(teamInstructor.getTeamInstructorId())
				.orElseThrow();
			//강사 지정 비용 추가
			designatedFee += permission.getDesignatedCost();
		}
		//강습자가 혼자가 아닌 경우
		if(size > 1) {
			OneToNOption oneToNOption = oneToNOptionRepository
				.findById(team.getTeamId())
				.orElseThrow();//에러 넣기
			if(size == 2) {
				peopleOptionFee += oneToNOption.getOneTwoFee();
			}
			else if(size == 3) {
				peopleOptionFee += oneToNOption.getOneThreeFee();
			}
			else if(size == 4) {
				peopleOptionFee += oneToNOption.getOneFourFee();
			}
			else {
				peopleOptionFee += oneToNOption.getOneNFee();
			}
			//강습 수준에 따른 금액 설정
			if(level > 1) {
				LevelOption levelOption = levelOptionRepository
					.findById(team.getTeamId())
					.orElseThrow();
				if(level == 2) levelOptionFee += levelOption.getIntermediateFee();
				else  levelOptionFee += levelOption.getAdvancedFee();
			}
		}

		LessonPaymentInfo lessonPaymentInfo = LessonPaymentInfo.builder()
			.lessonId(lessonId)
			.lesson(tmpLesson)
			.basicFee(basicFee)
			.designatedFee(designatedFee)
			.peopleOptionFee(peopleOptionFee)
			.levelOptionFee(levelOptionFee)
			.duration(request.getDuration())
			.build();

		LessonPaymentInfo tmpLessonPaymentInfo = lessonPaymentInfoRepository.save(lessonPaymentInfo);

		return null;
	}
}
