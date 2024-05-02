package com.go.ski.payment.core.service;

import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.payment.core.model.*;
import com.go.ski.payment.core.repository.*;
import com.go.ski.payment.support.dto.request.ApprovePaymentRequestDTO;
import com.go.ski.payment.support.dto.request.KakaopayApproveRequestDTO;
import com.go.ski.payment.support.dto.request.KakaopayPrepareRequestDTO;
import com.go.ski.payment.support.dto.request.ReserveLessonPaymentRequestDTO;
import com.go.ski.payment.support.dto.response.KakaopayApproveResponseDTO;
import com.go.ski.payment.support.dto.response.KakaopayPrepareResponseDTO;
import com.go.ski.payment.support.dto.response.OwnerPaymentHistoryResponseDTO;
import com.go.ski.payment.support.dto.response.UserPaymentHistoryResponseDTO;
import com.go.ski.payment.support.dto.util.StudentInfoDTO;
import com.go.ski.redis.dto.PaymentCacheDto;
import com.go.ski.redis.repository.PaymentCacheRepository;
import com.go.ski.schedule.core.service.ScheduleService;
import com.go.ski.schedule.support.exception.ScheduleExceptionEnum;
import com.go.ski.schedule.support.vo.ReserveScheduleVO;
import com.go.ski.team.core.model.Team;
import com.go.ski.team.core.repository.TeamRepository;
import com.go.ski.team.support.dto.TeamResponseDTO;
import com.go.ski.user.core.model.Instructor;
import com.go.ski.user.core.model.User;
import com.go.ski.user.core.repository.InstructorRepository;
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

import java.time.LocalDate;
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
    private String HOST = "https://open-api.kakaopay.com/online/v1/payment";
    private final RestTemplate restTemplate = new RestTemplate();
    private final ScheduleService scheduleService;

    private final TeamRepository teamRepository;
    private final InstructorRepository instructorRepository;
    private final LessonRepository lessonRepository;
    private final LessonInfoRepository lessonInfoRepository;
    private final LessonPaymentInfoRepository lessonPaymentInfoRepository;
    private final StudentInfoRepository studentInfoRepository;
    private final PaymentRepository paymentRepository;
    private final PaymentCacheRepository paymentCacheRepository;

    //카카오 페이에 보낼 요청의 헤더 값을 넣어주는 메소드
    public HttpHeaders getHeader(String mode) {
        HttpHeaders headers = new HttpHeaders();

        if (mode.equals("test")) headers.add("Authorization", "SECRET_KEY " + secretKeyDev);
        else headers.add("Authorization", "SECRET_KEY " + secretKey);

        headers.add("Content-type", "application/json");

        return headers;
    }

    // 사용자의 요청으로 생성되기 때문에 isOwn이 그냥 자체 서비스임 HttpServletRequest
    @Transactional
    public KakaopayPrepareResponseDTO getPrepareResponse(
            HttpServletRequest httpServletRequest,
            ReserveLessonPaymentRequestDTO request) {
        //예약자
        User user = (User) httpServletRequest.getAttribute("user");
        Team team = teamRepository.findById(request.getTeamId()).orElseThrow();
        Instructor instructor;
        if (request.getInstId() != null) instructor = instructorRepository.findById(request.getInstId()).get();
        else instructor = null;

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
                .toLessonPaymentInfoForPayment(basicFee, designatedFee, peopleOptionFee, levelOptionFee, request.getDuration());
        Integer totalFee = basicFee + designatedFee + peopleOptionFee + levelOptionFee;
        String itemName = team.getTeamName() + " 팀, 예약자 : " + user.getUserName() + " 외 " + size + "명";

        //만들어서 KAKAO랑 소통하기
        KakaopayPrepareRequestDTO kakaopayPrepareRequestDTO = KakaopayPrepareRequestDTO.toKakaopayPrepareRequestDTO(lesson, itemName, totalFee);
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

        User user = (User) httpServletRequest.getAttribute("user");

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
                .LessonPaymentInfo(tmpLessonPaymentInfo)
                .paymentStatus(0)
                .totalAmount(tmpLessonPaymentInfo.getBasicFee()
                        + tmpLessonPaymentInfo.getDesignatedFee()
                        + tmpLessonPaymentInfo.getLevelOptionFee()
                        + tmpLessonPaymentInfo.getPeopleOptionFee()
                )
                .chargeId(0)// 사용자 0? 100?
                .paymentDate(LocalDate.now()).build();
        paymentRepository.save(tmpPayment);

        // 이 정보는 굳이 내보내야하나?
        KakaopayApproveRequestDTO kakaopayApproveRequestDTO = KakaopayApproveRequestDTO.builder()
                .tid(request.getTid())
                .partnerOrderId("partner_order_id")//레슨 id
                .partnerUserId(String.valueOf(user.getUserId()))//유저 아이디
                .pgToken(request.getPgToken())//pg_token
                .build();

        // 강습 가능여부 판단 후 캐싱하는 메서드
        if (!scheduleService.scheduleCaching(paymentCache.getLesson().getTeam(), new ReserveScheduleVO(paymentCache))) {
            throw ApiExceptionFactory.fromExceptionEnum(ScheduleExceptionEnum.FAIL_ADD_SCHEDULE);
        }
        return requestApproveToKakao(kakaopayApproveRequestDTO);
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
        ResponseEntity<KakaopayPrepareResponseDTO> responseEntity = restTemplate.postForEntity(HOST + "/ready", requestEntity, KakaopayPrepareResponseDTO.class);

        return responseEntity.getBody();
    }

    //카카오 페이에 거래 승인 요청 메소드
    @Transactional
    public KakaopayApproveResponseDTO requestApproveToKakao(KakaopayApproveRequestDTO request) {
        HttpHeaders headers = getHeader("test");

        Map<String, String> params = new HashMap<>();
        params.put("cid", testId);
        params.put("tid", request.getTid());
        params.put("partner_order_id", request.getPartnerOrderId());
        params.put("partner_user_id", request.getPartnerUserId());
        params.put("pg_token", request.getPgToken());

        HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(params, headers);
        ResponseEntity<KakaopayApproveResponseDTO> responseEntity = restTemplate.postForEntity(HOST + "/approve", requestEntity, KakaopayApproveResponseDTO.class);

        // 여기서 결제 정보를 db에 저장
        return responseEntity.getBody();
    }

    @Transactional
    public List<UserPaymentHistoryResponseDTO> getUserPaymentHistories(HttpServletRequest httpServletRequest) {
        User user = (User) httpServletRequest.getAttribute("user");

        return lessonRepository.findStudentPaymentHistories(user.getUserId());
    }

    @Transactional
    public List<OwnerPaymentHistoryResponseDTO> getOwnerPaymentHistories(HttpServletRequest httpServletRequest) {
        User user = (User) httpServletRequest.getAttribute("user");
        //사장인지 확인
        //내 아래로 팀이 있는지 확인
        List<TeamResponseDTO> dummy = teamRepository.findTeamList(user.getUserId());
        //exception 만들기
        if (dummy.isEmpty()) throw new IllegalArgumentException("조회할 수 없습니다.");
        return lessonRepository.findOwnerPaymentHistories(user.getUserId());
    }

    public List<OwnerPaymentHistoryResponseDTO> getTeamPaymentHistories(HttpServletRequest httpServletRequest, Integer teamId) {
        User user = (User) httpServletRequest.getAttribute("user");
        boolean b = false;
        //사장인지 확인
        //내 아래로 팀이 있는지 확인
        List<TeamResponseDTO> dummy = teamRepository.findTeamList(user.getUserId());
        for (int id = 0; id < dummy.size(); id++) {
            if (Objects.equals(dummy.get(id).getTeamId(), teamId)) b = true;
        }
        log.info(user.getUserName());
        log.info(String.valueOf(dummy.size()));
        //exception 만들기
        if (!b) throw new IllegalArgumentException("조회할 수 없습니다.");

        return lessonRepository.findTeamPaymentHistories(teamId);
    }
}
