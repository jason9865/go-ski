package com.go.ski.team.core.service;

import com.go.ski.common.constant.FileUploadPath;
import com.go.ski.common.util.S3Uploader;
import com.go.ski.team.core.model.*;
import com.go.ski.team.core.repository.*;
import com.go.ski.team.support.dto.TeamCreateRequestDTO;
import com.go.ski.team.support.dto.TeamImageDTO;
import com.go.ski.user.core.model.User;
import com.go.ski.user.core.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class TeamService {

    private final TeamRepository teamRepository;
    private final UserRepository userRepository;
    private final SkiResortRepository skiResortRepository;
    private final TeamImageRepository teamImageRepository;
    private final LevelOptionRepository levelOptionRepository;
    private final OneToNOptionRepository oneToNOptionRepository;
    private final S3Uploader s3Uploader;


    @Transactional
    public void createTeam(TeamCreateRequestDTO request) {
        Integer userId = getUserId();
        User user = userRepository.findById(userId)
                .orElseThrow(() ->new RuntimeException("해당 유저가 없습니다!")); // 추후 변경

        SkiResort skiResort= skiResortRepository.findById(request.getResortId())
                .orElseThrow(() -> new RuntimeException("해당 리조트가 존재하지 않습니다!"));

        // 0. 이미지부터 S3에 저장
        String teamProfileUrl = s3Uploader.uploadFile(FileUploadPath.TEAM_PROFILE_PATH.path, request.getTeamProfileImage());

        // 1. 팀 생성
        Team team = Team.builder()
                .user(user)
                .skiResort(skiResort)
                .teamName(request.getTeamName())
                .teamProfileUrl(teamProfileUrl)
                .description(request.getDescription())
                .teamCost(request.getTeamCost())
                .dayoff(dayoffListToInteger(request.getDayoff()))
                .build();

        Team savedTeam = teamRepository.save(team);

        log.info("팀 생성 성공 - teamId : {}", savedTeam.getTeamId());
        // 2. 팀 이미지 생성
        List<TeamImageDTO> imageList = request.getTeamImages(); // requestDTO에 담겨있는 image들

        List<TeamImage> tobeSavedImages = new ArrayList<>();
        for(TeamImageDTO image : imageList) {
            String imageUrl = s3Uploader.uploadFile(FileUploadPath.TEAM_IMAGE_PATH.path,image.getImage());
            tobeSavedImages.add(TeamImage.builder().imageUrl(imageUrl).team(savedTeam).build());
        }

        teamImageRepository.saveAll(tobeSavedImages);
        log.info("팀 소개 이미지 저장 성공 - 소개 이미지 개수 : {}장", tobeSavedImages.size());
        
        // 3. 중고급 옵션 생성
        LevelOption levelOption = LevelOption.createLevelOption(savedTeam, request);
        levelOptionRepository.save(levelOption);
        log.info("중 고급 옵션 저장 성공");

        // 4. 1:N 옵션 생성
        OneToNOption oneToNOption = OneToNOption.createOneToNOption(savedTeam, request);
        oneToNOptionRepository.save(oneToNOption);
        log.info("1:N 옵션 저장 성공");
    }

    // 토큰에서 userId 추출
    public Integer getUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String userId = authentication.getName(); // getSubject()에서 반환한 userId
        return Integer.parseInt(userId);
    }

    public Integer dayoffListToInteger(List<Integer> dayoffList) {
        return dayoffList.stream()
                .mapToInt(num -> (int)Math.pow(2,num))
                .sum();
    }

}
