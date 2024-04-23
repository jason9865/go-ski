package com.go.ski.common.util;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.common.exception.CommonExceptionEnum;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

@Slf4j
@Component
@RequiredArgsConstructor
public class S3Uploader {

    private final AmazonS3 amazonS3;

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

    public String uploadFile(String filePath, MultipartFile multipartFile){
        log.info("bucket 이름 -> {}", bucket);
        log.info(multipartFile.getOriginalFilename());
        String fileName = filePath + "/" + createFileName(multipartFile.getOriginalFilename());
        // s3 업로드 시 메타데이터 설정; 파일크기와 콘텐츠 타입을 명시적으로 지정
        ObjectMetadata objectMetadata = new ObjectMetadata();
        objectMetadata.setContentLength(multipartFile.getSize());
        objectMetadata.setContentType(multipartFile.getContentType());

        // MultipartFile -> byte stream으로 변환해서 s3에 저장
        try (InputStream inputStream = multipartFile.getInputStream()) {
            amazonS3.putObject(new PutObjectRequest(bucket, fileName, inputStream, objectMetadata)
                    .withCannedAcl(CannedAccessControlList.PublicRead)); // 사진에 대한 읽기 권한은 public으로
        } catch (IOException e) {
            throw ApiExceptionFactory.fromExceptionEnum(CommonExceptionEnum.IMAGE_UPLOAD_ERROR);
        }

        return amazonS3.getUrl(bucket, fileName).toString();

    }

    public void deleteFile(String filePath, String imageUrl){
        try {
            amazonS3.deleteObject(bucket, filePath + "/" + imageUrl.split("/")[4]);
            log.info("Delete file - {}", imageUrl.split("/")[4]);
        } catch (AmazonServiceException e){
            log.error(e.getErrorMessage());
            throw ApiExceptionFactory.fromExceptionEnum(CommonExceptionEnum.IMAGE_DELETE_ERROR);
        }
    }

    public String updateFile(String filePath, MultipartFile multipartFile, String originalFileUrl) {

        // 기존 파일 삭제
        deleteFile(filePath, originalFileUrl);

        // 새로운 파일 추가
        return uploadFile(filePath, multipartFile);

    }



    // uuid와 확장자명을 이용하여 새로운 파일 이름 생성
    // example.jpg -> 5f62b792-3d22-4a02-a3ff-92fc133bd0fd.jpg
    private String createFileName(String fileName) {
        return UUID.randomUUID().toString().concat(getFileExtension(fileName));
    }

    // 파일 확장자명 추출
    private String getFileExtension(String fileName) {
        try {
            return fileName.substring(fileName.lastIndexOf("."));
        } catch (StringIndexOutOfBoundsException e) {
            throw ApiExceptionFactory.fromExceptionEnum(CommonExceptionEnum.INVALID_FILE_TYPE);
        }
    }

}
