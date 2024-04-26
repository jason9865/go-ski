package com.go.ski.lesson.core.controller;

import com.go.ski.common.response.ApiResponse;
import com.go.ski.lesson.core.service.LessonService;
import com.go.ski.lesson.support.dto.ReserveNoviceResponseDTO;
import com.go.ski.lesson.support.dto.ReserveRequestDTO;
import com.go.ski.lesson.support.vo.ReserveInfoVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1/lessson")
@RestController
public class LessonController {
    private final LessonService lessonService;

    @PostMapping("/reserve/novice")
    public ResponseEntity<ApiResponse<?>> reserveNovice(@RequestBody ReserveRequestDTO reserveRequestDTO) {
        log.info("강습조회 - 초급(팀리스트): {}", reserveRequestDTO);
        ReserveInfoVO reserveInfoVO = new ReserveInfoVO(reserveRequestDTO);
        List<ReserveNoviceResponseDTO> reserveNoviceResponseDTOs = lessonService.reserveNovice(reserveInfoVO);

        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(reserveNoviceResponseDTOs));
    }

    @PostMapping("/reserve/advanced")
    public ResponseEntity<ApiResponse<?>> reserveAdvanced(@RequestBody ReserveRequestDTO reserveRequestDTO) {
        log.info("강습조회 - 중/상급(강사리스트): {}", reserveRequestDTO);
        ReserveInfoVO reserveInfoVO = new ReserveInfoVO(reserveRequestDTO);
        List<Integer> instructorsList = lessonService.reserveAdvanced(reserveInfoVO);
        // 강사 id로 강사 정보를 가져오는 메서드를 호출해야함

        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(instructorsList));
    }
}
