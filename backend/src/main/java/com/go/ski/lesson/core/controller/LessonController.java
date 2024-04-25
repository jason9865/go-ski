package com.go.ski.lesson.core.controller;

import com.go.ski.common.response.ApiResponse;
import com.go.ski.lesson.core.service.LessonService;
import com.go.ski.lesson.support.dto.ReserveAdvancedRequestDTO;
import com.go.ski.lesson.support.dto.ReserveNoviceRequestDTO;
import com.go.ski.lesson.support.dto.ReserveNoviceResponseDTO;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1/lessson")
@RestController
public class LessonController {
    private final LessonService lessonService;

    @PostMapping("/reserve/novice")
    public ResponseEntity<ApiResponse<?>> reserveNovice(@RequestBody ReserveNoviceRequestDTO reserveNoviceRequestDTO) {
        log.info("강습조회 - 초급(팀리스트): {}", reserveNoviceRequestDTO);
        ReserveAdvancedRequestDTO reserveAdvancedRequestDTO = new ReserveAdvancedRequestDTO(reserveNoviceRequestDTO);
        List<ReserveNoviceResponseDTO> reserveNoviceResponseDTOs = lessonService.reserveNovice(reserveAdvancedRequestDTO);

        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(reserveNoviceResponseDTOs));
    }

    @PostMapping("/reserve/advanced")
    public ResponseEntity<ApiResponse<?>> reserveAdvanced(@RequestBody ReserveAdvancedRequestDTO reserveAdvancedRequestDTO) {
        log.info("강습조회 - 중/상급(강사리스트): {}", reserveAdvancedRequestDTO);
        List<Integer> instructorsList = lessonService.reserveAdvanced(reserveAdvancedRequestDTO);
        // 강사 id로 강사 정보를 가져오는 메서드를 호출해야함

        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(instructorsList));
    }
}
