package com.go.ski.payment.core.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.model.LessonInfo;
import com.go.ski.payment.core.model.LessonPaymentInfo;
import com.go.ski.payment.core.model.StudentInfo;
import com.go.ski.payment.core.repository.LessonInfoRepository;
import com.go.ski.payment.core.repository.LessonPaymentInfoRepository;
import com.go.ski.payment.core.repository.LessonRepository;
import com.go.ski.payment.core.repository.StudentInfoRepository;
import com.go.ski.payment.support.dto.request.KakaopayPrepareRequestDTO;
import com.go.ski.payment.support.dto.request.ReserveLessonPaymentRequestDTO;
import com.go.ski.payment.support.dto.response.KakaopayPrepareResponseDTO;
import com.go.ski.payment.support.dto.util.StudentInfoDTO;
import com.go.ski.team.core.model.Team;
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
	@Value("${pay.test_id}")
	public String testId;
	@Value("${pay.client_id}")
	public String clientId;
	@Value("${pay.client_secret}")
	public String clientSecret;
	@Value("${pay.secret_key}")
	public String secretKey;
	@Value("${pay.secret_key_dev}")
	public String secretKeyDev;
	@Value("${pay.approval_url}")
	public String approvalUrl;
	@Value("${pay.cancel_url}")
	public String cancelUrl;
	@Value("${pay.fail_url}")
	public String failUrl;
	private String HOST = "https://open-api.kakaopay.com/online/v1/payment";
	private final RestTemplate restTemplate = new RestTemplate();

	private final TeamRepository teamRepository;
	private final InstructorRepository instructorRepository;
	private final LessonRepository lessonRepository;
	private final LessonInfoRepository lessonInfoRepository;
	private final LessonPaymentInfoRepository lessonPaymentInfoRepository;
	private final StudentInfoRepository studentInfoRepository;

	// 사용자의 요청으로 생성되기 때문에 isOwn이 그냥 자체 서비스임 HttpServletRequest
	@Transactional
	public KakaopayPrepareResponseDTO getResponse(
		HttpServletRequest httpServletRequest,
		ReserveLessonPaymentRequestDTO request) {
		//예약자
		User user = (User)httpServletRequest.getAttribute("user");
		log.info("{}", user);
		Team team = teamRepository.getReferenceById(request.getTeamId());
		Instructor instructor;
		if(request.getInstId()!=null) instructor = instructorRepository.findById(request.getInstId()).get();
		else instructor = null;

		int size = request.getStudentInfo().size();
		// 레슨 생성
		Lesson lesson = Lesson.toLessonForPayment(user, team, instructor, 0);
		Lesson tmpLesson = lessonRepository.save(lesson);
		log.info("여기 아님1");
		LessonInfo lessonInfo = LessonInfo.toLessonInfoForPayment(tmpLesson, request);
		LessonInfo tmpLessonInfo = lessonInfoRepository.save(lessonInfo);
		log.info("여기 아님2");

		//사용자 정보 입력 안되면 Enum 갈아야함
		for(StudentInfoDTO studentInfoDTO : request.getStudentInfo()) {
			StudentInfo studentInfo = StudentInfo.toStudentInfoForPayment(tmpLessonInfo, studentInfoDTO);
			log.info(studentInfo.getAge().toString());
			studentInfoRepository.save(studentInfo);
		}
		log.info("여기 아님3");
		// 2번 생성된 예약정보를 바탕으로 kakaoPayService에 필요한 변수를 넣기
		Integer basicFee = request.getBasicFee();
		Integer designatedFee = request.getDesignatedFee();
		Integer peopleOptionFee = request.getPeopleOptionFee();
		Integer levelOptionFee = request.getLevelOptionFee();

		LessonPaymentInfo lessonPaymentInfo = LessonPaymentInfo
			.toLessonPaymentInfoForPayment(tmpLesson, basicFee, designatedFee, peopleOptionFee, levelOptionFee, request.getDuration());
		Integer totalFee = basicFee + designatedFee + peopleOptionFee + levelOptionFee;
		String itemName = team.getTeamName() + " 팀, 예약자 : " + user.getUserName() + " 외 " + size + "명";
		//결제 정보 저장 -> 어떻게 쓸지 생각해야함
		LessonPaymentInfo tmpLessonPaymentInfo = lessonPaymentInfoRepository.save(lessonPaymentInfo);
		log.info("여기 아님4");
		//만들어서 KAKAO랑 소통하기
		KakaopayPrepareRequestDTO kakaopayPrepareRequestDTO = KakaopayPrepareRequestDTO.toKakaopayPrepareRequestDTO(lesson, itemName, totalFee);

		return getPrepareResponse(kakaopayPrepareRequestDTO);
	}

	@Transactional
	public KakaopayPrepareResponseDTO getPrepareResponse(KakaopayPrepareRequestDTO request) {
		//헤더 설정 추후에 서비스 모드로 변경
		HttpHeaders headers = getHeader("test");

		Map<String, String> params = new HashMap<>();
		params.put("cid", testId);
		params.put("partner_order_id", request.getPartnerOrderId());
		params.put("partner_user_id", request.getPartnerUserId());//실제로는 무슨 값이 들어가야하는지?
		params.put("item_name", request.getItemName());//팀 이름, 레벨, 명 수 이렇게 묶을 생각임
		params.put("quantity", Integer.toString(request.getQuantity()));// 무조건 1
		params.put("total_amount", Integer.toString(request.getTotalAmount()));// 계산한 값 보내줌
		params.put("tax_free_amount", Integer.toString(request.getTaxFreeAmount()));// 부가가치세가 면제
		params.put("approval_url", approvalUrl);//url 보내줌
		params.put("cancel_url", cancelUrl);//url 보내줌
		params.put("fail_url", failUrl);//url 보내줌

		log.info("data : {}", params);
		HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(params, headers);
		ResponseEntity<KakaopayPrepareResponseDTO> responseEntity = restTemplate.postForEntity(HOST + "/ready", requestEntity, KakaopayPrepareResponseDTO.class);
		log.info("data : {}", responseEntity);
		return responseEntity.getBody();
	}
	public HttpHeaders getHeader(String mode) {
		HttpHeaders headers = new HttpHeaders();

		if(mode.equals("test")) headers.add("Authorization", "SECRET_KEY " + secretKeyDev);
		else headers.add("Authorization", "SECRET_KEY " + secretKey);

		headers.add("Content-type", "application/json");

		return headers;
	}
}
