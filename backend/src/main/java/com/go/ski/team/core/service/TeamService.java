package com.go.ski.team.core.service;

import com.go.ski.common.constant.FileUploadPath;
import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.common.util.S3Uploader;
import com.go.ski.team.core.model.*;
import com.go.ski.team.core.repository.*;
import com.go.ski.team.support.dto.TeamCreateRequestDTO;
import com.go.ski.team.support.dto.TeamInfoResponseDTO;
import com.go.ski.team.support.dto.TeamResponseDTO;
import com.go.ski.team.support.dto.TeamUpdateRequestDTO;
import com.go.ski.team.support.exception.TeamExceptionEnum;
import com.go.ski.team.support.vo.TeamImageVO;
import com.go.ski.user.core.model.User;
import com.go.ski.user.core.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import reactor.core.publisher.Sinks;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import static com.go.ski.common.util.TimeConvertor.dayoffListToInteger;
import static com.go.ski.team.support.dto.TeamInfoResponseDTO.toDayOfWeek;

@Slf4j
@Service
@RequiredArgsConstructor
public class TeamService {

    private final TeamRepository teamRepository;
    private final TeamInstructorRepository teamInstructorRepository;
    private final SkiResortRepository skiResortRepository;
    private final TeamImageRepository teamImageRepository;
    private final LevelOptionRepository levelOptionRepository;
    private final OneToNOptionRepository oneToNOptionRepository;
    private final PermissionRepository permissionRepository;
    private final S3Uploader s3Uploader;


    @Transactional
    public void createTeam(TeamCreateRequestDTO request,User user) {
        log.info("TeamService.createTeam");
        // Team 테이블에 저장할 SkiResort 생성
        SkiResort skiResort = getSkiResort(request.getResortId());

        // 0. 프로필 이미지부터 S3에 저장
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
        if (request.getTeamImages() != null) {
            saveTeamImages(request.getTeamImages(),savedTeam);
        }

        // 3. 중고급 옵션 생성
        LevelOption levelOption = LevelOption.createLevelOption(savedTeam, request);
        levelOptionRepository.save(levelOption);
        log.info("중 고급 옵션 저장 성공");

        // 4. 1:N 옵션 생성
        OneToNOption oneToNOption = OneToNOption.createOneToNOption(savedTeam, request);
        oneToNOptionRepository.save(oneToNOption);
        log.info("1:N 옵션 저장 성공");
    }

    @Transactional
    public TeamInfoResponseDTO getTeamInfo(Integer teamId) {

        // 팀 이미지를 제외한 팀 정보 데이터를 우선 가져오고
        TeamInfoResponseDTO teamInfoResponseDTO = teamRepository.findTeamInfo(teamId)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(TeamExceptionEnum.TEAM_NOT_FOUND));

        // teadId에 해당하는 이미지를 가져온 다음
        List<TeamImageVO> teamImages = teamImageRepository.findByTeamId(teamId)
                .stream()
                .map(TeamImageVO::toVO)
                .toList()
                ;

        // teamResponseDTO에 저장
        teamInfoResponseDTO.setTeamImages(teamImages);

        // bitmask -> List로 변환
        teamInfoResponseDTO.setDayoffList(toDayOfWeek(teamInfoResponseDTO.getDayoff()));

        return teamInfoResponseDTO;
    }

    @Transactional
    public void updateTeamInfo(User user, Integer teamId, TeamUpdateRequestDTO request) {
        Team team = getTeam(teamId);

        // Team 테이블에 저장할 SkiResort 생성
        SkiResort skiResort = getSkiResort(request.getResortId());

        log.info("1. 팀 정보 수정");
        // 1. 팀 정보 수정
        team.updateTeam(request, skiResort);

        // s3에서 프로필 이미지 변경
        if(request.getTeamProfileImage() != null) {
            String originalFileUrl = team.getTeamProfileUrl();
            String newTeamProfileUrl = s3Uploader.updateFile(FileUploadPath.TEAM_PROFILE_PATH.path, request.getTeamProfileImage(), originalFileUrl);
            team.updateTeamProfile(newTeamProfileUrl);
        }

        Team savedTeam = teamRepository.save(team);
        log.info("팀 정보 수정 성공 - teamId : {}", savedTeam.getTeamId());

        log.info("2. 팀 소개 이미지 변경");
        // 2. 팀 소개 이미지 변경
        // 예전 팀 소개 사진들
        List<TeamImage> teamImages = teamImageRepository.findByTeamId(teamId);

        // 2-1. 새로운 이미지 s3에 저장
        if(request.getNewTeamImages() != null) {
            saveTeamImages(request.getNewTeamImages(),savedTeam);
        }

        // 2-2. 예전 이미지 s3와 TeamImage테이블에서 삭제
        if (request.getDeleteTeamImageIds() != null) {
            List<TeamImage> oldTeamImages = teamImageRepository.findAllById(request.getDeleteTeamImageIds());
            deleteTeamImages(oldTeamImages);
        }

        // 3. 중고급 옵션 수정
        LevelOption levelOption = levelOptionRepository.findByTeam(team);
        levelOption.update(request);
        log.info("중 고급 옵션 저장 성공");

        // 4. 1:N 옵션 수정
        OneToNOption oneToNOption = oneToNOptionRepository.findByTeam(team);
        oneToNOption.update(request);
        log.info("1:N 옵션 저장 성공");

    }

    @Transactional
    public List<TeamResponseDTO> getTeamList(User user) {
        return teamRepository.findTeamList(user.getUserId());
    }

    @Transactional
    public void deleteTeam(Integer teamId) {
        Team team = getTeam(teamId);
        List<TeamInstructor> teamInstructors = getTeamInstructor(team);

        // s3에서 팀 소개 사진 삭제
        List<TeamImage> oldTeamImages = teamImageRepository.findByTeamId(teamId);
        for(TeamImage image : oldTeamImages) {
            s3Uploader.deleteFile(image.getImageUrl());
        }

        // 팀 프로필 삭제
        s3Uploader.deleteFile(team.getTeamProfileUrl());

        // 강습 팀 테이블 강사 삭제
        teamInstructorRepository.deleteAllInBatch(teamInstructors);

        // 팀 삭제
        teamRepository.delete(team);
    }

    private void saveTeamImages(List<MultipartFile> newTeamImages, Team savedTeam) {
        List<TeamImage> tobeSavedImages = new ArrayList<>();
        for(MultipartFile image : newTeamImages) {
            String newTeamImageUrl = s3Uploader.uploadFile(FileUploadPath.TEAM_IMAGE_PATH.path,image);
            tobeSavedImages.add(TeamImage.builder().imageUrl(newTeamImageUrl).team(savedTeam).build());
        }

        teamImageRepository.saveAll(tobeSavedImages);
        log.info("팀 소개 이미지 저장 성공 - 새로 올라온 소개 이미지 개수 : {}장", tobeSavedImages.size());
    }

    private void deleteTeamImages(List<TeamImage> oldTeamImages) {
        // teamId로 teamImage 리스트 가져오기
        for(TeamImage image : oldTeamImages) {
            s3Uploader.deleteFile(image.getImageUrl());
        }

        teamImageRepository.deleteAllInBatch(oldTeamImages);
        log.info("팀 소개 이미지 삭제 성공 - 삭제된 소개 이미지 개수 : {}장", oldTeamImages.size());
    }

    public SkiResort getSkiResort(Integer resortId) {
        return skiResortRepository.findById(resortId)
                .orElseThrow(() -> new RuntimeException("해당 리조트가 존재하지 않습니다!"));
    }

    public Team getTeam(Integer teamId) {
        return teamRepository.findById(teamId)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(TeamExceptionEnum.TEAM_NOT_FOUND))
                ;
    }

    public List<TeamInstructor> getTeamInstructor(Team team) {
        return teamInstructorRepository.findByTeam(team)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(TeamExceptionEnum.TEAM_INSTRUCTOR_NOT_FOUND));
    }


}
