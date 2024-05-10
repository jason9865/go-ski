package com.go.ski.payment.core.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.notification.support.EventPublisher;
import com.go.ski.payment.core.model.*;
import com.go.ski.payment.core.repository.*;
import com.go.ski.payment.support.dto.request.*;
import com.go.ski.payment.support.dto.response.*;
import com.go.ski.payment.support.dto.util.StudentInfoDTO;
import com.go.ski.payment.support.dto.util.TotalPaymentDTO;
import com.go.ski.payment.support.dto.util.TotalSettlementDTO;
import com.go.ski.redis.dto.PaymentCacheDto;
import com.go.ski.redis.repository.PaymentCacheRepository;
import com.go.ski.schedule.core.service.ScheduleService;
import com.go.ski.schedule.support.exception.ScheduleExceptionEnum;
import com.go.ski.team.core.model.Team;
import com.go.ski.team.core.repository.TeamRepository;
import com.go.ski.team.support.dto.TeamResponseDTO;
import com.go.ski.user.core.model.Instructor;
import com.go.ski.user.core.model.User;
import com.go.ski.user.core.repository.InstructorRepository;
import com.go.ski.user.core.repository.UserRepository;

import io.codef.api.EasyCodef;
import io.codef.api.EasyCodefServiceType;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.io.UnsupportedEncodingException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

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
	@Value("${codef.key}")
	private String codefKey;
	@Value("${codef.demo.client.id}")
	private String codefId;
	@Value("${codef.demo.client.secret}")
	private String codefSecret;
	private String HOST = "https://open-api.kakaopay.com/online/v1/payment";
	private final RestTemplate restTemplate = new RestTemplate();
	private final ScheduleService scheduleService;

	private final UserRepository userRepository;
	private final TeamRepository teamRepository;
	private final InstructorRepository instructorRepository;
	private final LessonRepository lessonRepository;
	private final LessonInfoRepository lessonInfoRepository;
	private final LessonPaymentInfoRepository lessonPaymentInfoRepository;
	private final StudentInfoRepository studentInfoRepository;
	private final PaymentRepository paymentRepository;
	private final PaymentCacheRepository paymentCacheRepository;
	private final SettlementRepository settlementRepository;
	private final ChargeRepository chargeRepository;
	private final EventPublisher eventPublisher;

	//카카오 페이에 보낼 요청의 헤더 값을 넣어주는 메소드
	public HttpHeaders getHeader(String mode) {
		HttpHeaders headers = new HttpHeaders();

		if (mode.equals("test"))
			headers.add("Authorization", "SECRET_KEY " + secretKeyDev);
		else
			headers.add("Authorization", "SECRET_KEY " + secretKey);

		headers.add("Content-type", "application/json");

		return headers;
	}

	// 사용자의 요청으로 생성되기 때문에 isOwn이 그냥 자체 서비스임 HttpServletRequest
	@Transactional
	public KakaopayPrepareResponseDTO getPrepareResponse(
		HttpServletRequest httpServletRequest,
		ReserveLessonPaymentRequestDTO request) {
		//예약자
		User user = (User)httpServletRequest.getAttribute("user");
		Team team = teamRepository.findById(request.getTeamId()).orElseThrow();
		Instructor instructor;
		if (request.getInstId() != null)
			instructor = instructorRepository.findById(request.getInstId()).orElseThrow();
		else
			instructor = null;

		int size = request.getStudentInfo().size();
		// 레슨 생성
		Lesson lesson = Lesson.toLessonForPayment(user, team, instructor, 0);
		LessonInfo lessonInfo = LessonInfo.toLessonInfoForPayment(request);

		// 2번 생성된 예약정보를 바탕으로 kakaoPayService에 필요한 변수를 넣기
		Integer basicFee = request.getBasicFee();
		Integer designatedFee = request.getDesignatedFee();
		Integer peopleOptionFee = request.getPeopleOptionFee();
		Integer levelOptionFee = request.getLevelOptionFee();

		LessonPaymentInfo lessonPaymentInfo = LessonPaymentInfo
			.toLessonPaymentInfoForPayment(basicFee, designatedFee, peopleOptionFee, levelOptionFee);

		Integer totalFee = (basicFee + peopleOptionFee + levelOptionFee) * request.getDuration() + designatedFee;
		String itemName = team.getTeamName() + " 팀, 예약자 : " + user.getUserName() + " 외 " + size + "명";

		//만들어서 KAKAO랑 소통하기
		KakaopayPrepareRequestDTO kakaopayPrepareRequestDTO = KakaopayPrepareRequestDTO.toKakaopayPrepareRequestDTO(
			lesson, itemName, totalFee);
		KakaopayPrepareResponseDTO kakaopayPrepareResponseDTO = requestPrepareToKakao(kakaopayPrepareRequestDTO);

		String tid = kakaopayPrepareResponseDTO.getTid();
		PaymentCacheDto paymentCache = PaymentCacheDto.builder()
			.tid(tid)
			.lesson(lesson)
			.lessonInfo(lessonInfo)
			.lessonPaymentInfo(lessonPaymentInfo)
			.studentInfos(request.getStudentInfo())
			.build();

		paymentCacheRepository.save(paymentCache);
		return kakaopayPrepareResponseDTO;
	}

	// 결제 승인
	// 결제 테이블 생성해야함
	@Transactional
	public KakaopayApproveResponseDTO getApproveResponse(
		HttpServletRequest httpServletRequest,
		ApprovePaymentRequestDTO request) {

		User user = (User)httpServletRequest.getAttribute("user");

		PaymentCacheDto paymentCache = paymentCacheRepository
			.findById(request.getTid())
			.orElseThrow();

		Lesson tmpLesson = lessonRepository.save(paymentCache.getLesson());
		LessonInfo tmpLessonInfo = LessonInfo.builder()
			.lessonId(tmpLesson.getLessonId())
			.lesson(tmpLesson)
			.lessonDate(paymentCache.getLessonInfo().getLessonDate())
			.startTime(paymentCache.getLessonInfo().getStartTime())
			.duration(paymentCache.getLessonInfo().getDuration())
			.lessonType(paymentCache.getLessonInfo().getLessonType())
			.studentCount(paymentCache.getLessonInfo().getStudentCount())
			.lessonStatus(paymentCache.getLessonInfo().getLessonStatus())
			.build();

		lessonInfoRepository.save(tmpLessonInfo);
		for (StudentInfoDTO studentInfoDTO : paymentCache.getStudentInfos()) {
			StudentInfo tmpStudentInfo = StudentInfo.toStudentInfoForPayment(tmpLessonInfo, studentInfoDTO);
			studentInfoRepository.save(tmpStudentInfo);
		}

		LessonPaymentInfo tmpLessonPaymentInfo = LessonPaymentInfo.builder()
			.lessonId(tmpLesson.getLessonId())
			.lesson(tmpLesson)
			.basicFee(paymentCache.getLessonPaymentInfo().getBasicFee())
			.designatedFee(paymentCache.getLessonPaymentInfo().getDesignatedFee())
			.levelOptionFee(paymentCache.getLessonPaymentInfo().getLevelOptionFee())
			.peopleOptionFee(paymentCache.getLessonPaymentInfo().getPeopleOptionFee())
			.build();
		lessonPaymentInfoRepository.save(tmpLessonPaymentInfo);

		Payment tmpPayment = Payment.builder()
			.lessonPaymentInfo(tmpLessonPaymentInfo)
			.totalAmount(tmpLessonPaymentInfo.getBasicFee()
				+ tmpLessonPaymentInfo.getDesignatedFee()
				+ tmpLessonPaymentInfo.getLevelOptionFee()
				+ tmpLessonPaymentInfo.getPeopleOptionFee()
			)
			.paymentStatus(0)
			.chargeId(0)// 사용자 0? 100?
			.tid(paymentCache.getTid())
			.paymentDate(LocalDateTime.now()).build();
		paymentRepository.save(tmpPayment);

		//정산 테이블에 추가
		Team team = teamRepository.findById(tmpLesson.getTeam().getTeamId()).orElseThrow();
		int ownerId = team.getUser().getUserId();
		User owner = userRepository.findById(ownerId).orElseThrow();
		//사장이 없으면 Exception
		RecentSettlementRecordResponseDTO recentSettlementRecordResponseDTO = settlementRepository.findRecentBalance(
			ownerId);
		Integer lastBalance = recentSettlementRecordResponseDTO.getBalance();
		if (lastBalance == null) {
			lastBalance = 0;
		}

		String timeString = tmpLessonInfo.getStartTime();

		// String을 LocalTime으로 변환
		LocalTime time = LocalTime.parse(timeString, DateTimeFormatter.ofPattern("HHmm"));

		// LocalDateTime으로 결합
		LocalDateTime dateTime = LocalDateTime.of(tmpLessonInfo.getLessonDate(), time);

		Settlement settlement = Settlement.builder()
			.settlementAmount(tmpPayment.getTotalAmount())
			.balance(lastBalance + tmpPayment.getTotalAmount())
			.depositStatus(0)
			.settlementDate(dateTime)
			.user(owner)
			.build();

		settlementRepository.save(settlement);
		// 이 정보는 굳이 내보내야하나?
		KakaopayApproveRequestDTO kakaopayApproveRequestDTO = KakaopayApproveRequestDTO.builder()
			.tid(request.getTid())
			.partnerOrderId("partner_order_id")//뭐 넣을지 고민하기
			.partnerUserId(String.valueOf(user.getUserId()))//유저 아이디
			.pgToken(request.getPgToken())//pg_token
			.build();

		//		String deviceType = httpServletRequest.getHeader("DeviceType");
		//        eventPublisher.publish(tmpLesson, tmpLessonInfo,deviceType);

		// 강습 가능여부 판단 후 캐싱하는 메서드
		if (!scheduleService.scheduleCaching(paymentCache.getLesson().getTeam(),
			paymentCache.getLessonInfo().getLessonDate())) {
			throw ApiExceptionFactory.fromExceptionEnum(ScheduleExceptionEnum.FAIL_ADD_SCHEDULE);
		}

		String deviceType = httpServletRequest.getHeader("DeviceType");

		return requestApproveToKakao(kakaopayApproveRequestDTO,tmpLesson, tmpLessonInfo, deviceType, paymentCache);
	}

	@Transactional
	public void getCancelResponse(
		CancelPaymentRequestDTO request) {

		//lessonId를 받았음
		//lesson이 없으면 에러 반환
		Lesson lesson = lessonRepository.findById(request.getLessonId()).orElseThrow();
		LessonInfo lessonInfo = lessonInfoRepository.findById(request.getLessonId()).orElseThrow();
		LocalDate reservationDate = lessonInfo.getLessonDate();
		Payment payment = paymentRepository.findByLessonPaymentInfoLessonId(request.getLessonId());

		// 예약일이 지금보다 뒤에 있으면 취소 가능
		// 반환 금액과 chargeId 변경해주기
		long dayDiff = ChronoUnit.DAYS.between(LocalDate.now(), reservationDate);
		int chargeId = 3;
		int paymentStatus = 2;

		// 돈을 바로 송금 해야함
		// 날짜  확인
		// 예약 후 취소시 : 전액 환불
		if (dayDiff > 7) {
			chargeId = 1;
		}
		// 이용일 7일 이전 취소 시 : 예약금의 50% 환불
		else if (dayDiff > 2) {
			chargeId = 2;
		}

		Charge charge = chargeRepository.findById(chargeId).orElseThrow();
		double studentChargeRate = charge.getStudentChargeRate() / 100.0;
		double ownerChargeRate = charge.getOwnerChargeRate() / 100.0;

		//이걸로 결제 취소 시켜줘야함
		double payback = payment.getTotalAmount() * studentChargeRate;
		double settlementAmount = payment.getTotalAmount() * ownerChargeRate;
		//강의 상태 강의 취소(2)로 변경
		lessonInfo.setLessonStatus(2);
		lessonInfoRepository.save(lessonInfo);

		//정산 테이블에 추가
		int ownerId = lesson.getTeam().getUser().getUserId();
		User owner = userRepository.findById(ownerId).orElseThrow();
		//사장이 없으면 Exception
		RecentSettlementRecordResponseDTO recentSettlementRecordResponseDTO = settlementRepository.findRecentBalance(
			ownerId);
		int lastBalance = recentSettlementRecordResponseDTO.getBalance();
		Settlement settlement = Settlement.builder()
			.settlementAmount((int)settlementAmount)
			.balance(lastBalance + (int)settlementAmount)
			.depositStatus(0)
			.settlementDate(LocalDateTime.now())
			.user(owner)
			.build();

		settlementRepository.save(settlement);
		// 여기서는 스케줄 없애기
		scheduleService.scheduleCaching(lesson.getTeam(), lessonInfo.getLessonDate());

		if(dayDiff <= 2) return;

		Payment tmpPayment = Payment.builder()
			.tid(payment.getTid())
			.lessonPaymentInfo(payment.getLessonPaymentInfo())
			.totalAmount((int)payback)
			.paymentStatus(paymentStatus)
			.chargeId(chargeId)
			.paymentDate(payment.getPaymentDate())
			.paybackDate(LocalDateTime.now())
			.build();
		paymentRepository.save(tmpPayment);

		// 여기서 카카오 페이 결제 취소 API 보냄
		KakaopayCancelRequestDTO kakaopayCancelRequestDTO = KakaopayCancelRequestDTO.builder()
			//tid 그대로 입력
			.cid(testId)
			.tid(payment.getTid())
			.cancelAmount((int)payback)
			.cancelTaxFreeAmount(0)
			.build();
		requestCancelToKakao(kakaopayCancelRequestDTO);
	}

	//카카오 페이에 보내는 준비 요청 메소드
	@Transactional
	public KakaopayPrepareResponseDTO requestPrepareToKakao(KakaopayPrepareRequestDTO request) {
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

		HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(params, headers);
		ResponseEntity<KakaopayPrepareResponseDTO> responseEntity = restTemplate.postForEntity(HOST + "/ready",
			requestEntity, KakaopayPrepareResponseDTO.class);

		return responseEntity.getBody();
	}

	//카카오 페이에 거래 승인 요청 메소드
	@Transactional
	public KakaopayApproveResponseDTO requestApproveToKakao(KakaopayApproveRequestDTO request, Lesson lesson,
															LessonInfo lessonInfo, String deviceType,
															PaymentCacheDto paymentCache) {
		HttpHeaders headers = getHeader("test");

		Map<String, String> params = new HashMap<>();
		params.put("cid", testId);
		params.put("tid", request.getTid());
		params.put("partner_order_id", request.getPartnerOrderId());
		params.put("partner_user_id", request.getPartnerUserId());
		params.put("pg_token", request.getPgToken());

		HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(params, headers);
		ResponseEntity<KakaopayApproveResponseDTO> responseEntity = restTemplate.postForEntity(HOST + "/approve",
			requestEntity, KakaopayApproveResponseDTO.class);

//		eventPublisher.publish(lesson, lessonInfo, paymentCache, deviceType);

		// 여기서 결제 정보를 db에 저장
		return responseEntity.getBody();
	}

	public KakaopayCancelResponseDTO requestCancelToKakao(KakaopayCancelRequestDTO request) {
		HttpHeaders headers = getHeader("test");
		Map<String, String> params = new HashMap<>();
		params.put("cid", testId);
		params.put("tid", request.getTid());
		params.put("cancel_amount", String.valueOf(request.getCancelAmount()));
		params.put("cancel_tax_free_amount", String.valueOf(request.getCancelTaxFreeAmount()));

		log.info("params : {}", params);

		HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(params, headers);
		ResponseEntity<KakaopayCancelResponseDTO> responseEntity = restTemplate.postForEntity(HOST + "/cancel",
			requestEntity, KakaopayCancelResponseDTO.class);
		log.info("data : {}", responseEntity);

		return responseEntity.getBody();
	}

	@Transactional
	public List<UserPaymentHistoryResponseDTO> getUserPaymentHistories(HttpServletRequest httpServletRequest) {
		User user = (User)httpServletRequest.getAttribute("user");

		return lessonRepository.findStudentPaymentHistories(user.getUserId());
	}

	@Transactional
	public List<OwnerPaymentHistoryResponseDTO> getOwnerPaymentHistories(HttpServletRequest httpServletRequest) {
		User user = (User)httpServletRequest.getAttribute("user");
		//사장인지 확인
		//내 아래로 팀이 있는지 확인
		List<TeamResponseDTO> dummy = teamRepository.findTeamList(user.getUserId());
		//exception 만들기
		if (dummy.isEmpty())
			throw new IllegalArgumentException("조회할 수 없습니다.");
		return lessonRepository.findOwnerPaymentHistories(user.getUserId());
	}

	@Transactional
	public List<OwnerPaymentHistoryResponseDTO> getTeamPaymentHistories(HttpServletRequest httpServletRequest,
		Integer teamId) {
		User user = (User)httpServletRequest.getAttribute("user");
		boolean b = false;
		//사장인지 확인
		//내 아래로 팀이 있는지 확인
		List<TeamResponseDTO> dummy = teamRepository.findTeamList(user.getUserId());
		for (int id = 0; id < dummy.size(); id++) {
			if (Objects.equals(dummy.get(id).getTeamId(), teamId))
				b = true;
		}
		//exception 만들기
		if (!b)
			throw new IllegalArgumentException("조회할 수 없습니다.");

		return lessonRepository.findTeamPaymentHistories(teamId);
	}

	// 그 동안의 출금 내역을 조회
	@Transactional
	public List<WithdrawalResponseDTO> getWithdrawalList(HttpServletRequest httpServletRequest) {
		User user = (User)httpServletRequest.getAttribute("user");
		return settlementRepository.findWithrawalList(user.getUserId());
	}

	// 가능 금액을 조회
	// 내 총 핀매금액 - 총 정산 금액
	// 정산 가능 금액 구했으면 알아서 다시 요청하지마라 프론트
	// 이거는 뭈쓸모가 맞다
	@Transactional
	public Integer getBalance(HttpServletRequest httpServletRequest) {
		User user = (User)httpServletRequest.getAttribute("user");

		int balance = 0;
		List<TotalPaymentDTO> totalPayments = paymentRepository.findTotalPayment(user.getUserId());
		List<TotalSettlementDTO> totalSettlements = settlementRepository.findBySettlements(user.getUserId());

		for (TotalPaymentDTO tmp : totalPayments) {
			balance += tmp.getChargeRate() * tmp.getTotalAmount() / 100;
		}
		for (TotalSettlementDTO tmp : totalSettlements) {
			balance -= tmp.getSettlementAmount();
		}
		// 잔액 total(현재 기준 예약 날짜 지난것들)
		// minus
		// 출금 내역 리스트
		return balance;
	}

	public VerifyAccountResponseDTO requestToCodeF(VerifyAccountRequestDTO verifyAccountRequestDTO) throws
		UnsupportedEncodingException,
		JsonProcessingException,
		InterruptedException {
		EasyCodef codef = new EasyCodef();
		codef.setPublicKey(codefKey);
		codef.setClientInfoForDemo(codefId, codefSecret);

		// 안되면 codeF 데모버전 만드셈
		verifyAccountRequestDTO.getBank();
		HashMap<String, Object> params = new HashMap<>();
		params.put("bank", verifyAccountRequestDTO.getBank());
		params.put("account", verifyAccountRequestDTO.getAccount());
		params.put("identity", verifyAccountRequestDTO.getIdentity());

		//데모버전임
		//추후 변경 요망
		String name = codef.requestProduct("https://development.codef.io/v1/kr/bank/a/account/holder-authentication",
			EasyCodefServiceType.DEMO, params);
		boolean isValid = name.equals(verifyAccountRequestDTO.getName());
		return VerifyAccountResponseDTO.builder().isValid(isValid).build();
	}

	public boolean checkAuthorization(Integer lessonId, HttpServletRequest httpServletRequest) {
		User user = (User)httpServletRequest.getAttribute("user");
		Lesson lesson = lessonRepository.findById(lessonId).orElseThrow();

		return user.getUserId().equals(lesson.getUser().getUserId());
	}

	@Transactional
	public LessonCostResponseDTO getLessonCost(Integer lessonId) {
		return lessonRepository.findLessonCost(lessonId);
	}
}
