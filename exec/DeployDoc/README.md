# 포팅 메뉴얼

# 1. 서버 아키텍처

![고스키 아키텍처 다이어그램.png](%E1%84%91%E1%85%A9%E1%84%90%E1%85%B5%E1%86%BC%20%E1%84%86%E1%85%A6%E1%84%82%E1%85%B2%E1%84%8B%E1%85%A5%E1%86%AF%208ab793bfef624d48bf67e4ca5067fc86/%25EA%25B3%25A0%25EC%258A%25A4%25ED%2582%25A4_%25EC%2595%2584%25ED%2582%25A4%25ED%2585%258D%25EC%25B2%2598_%25EB%258B%25A4%25EC%259D%25B4%25EC%2596%25B4%25EA%25B7%25B8%25EB%259E%25A8.png)

# 2. 배포 환경/기술 스택

## 2.1 COMMON

- Server: Ubuntu 20.04.6 LTS
- Docker: 25.0.4
- jenkins : 2.448
- nginx : 1.18.0
- mariaDB: 11.3.2
- Redis: 7.2.4

## 2.2 **FRONT**

### 2.2.1 Framework

- Flutter 3.19.6

### 2.2.2 Language

- Dart 3.3.4

### 2.2.3 Libraries

- DevTools 2.31.1
- cupertino_icons: ^1.0.6
- logger: ^2.2.0
- get: ^4.6.6
- easy_localization: ^3.0.6
- intl: ^0.18.1
- image_picker: ^1.1.0
- flutter_svg: ^2.0.10
- kakao_flutter_sdk: ^1.9.1+2
- flutter_dotenv: ^5.1.0
- flutter_secure_storage: ^9.0.0
- http: ^1.2.1
- dio: ^5.4.3+1
- firebase_core: ^2.30.1
- firebase_messaging: ^14.9.1
- flutter_local_notifications: ^17.1.1
- flutter_native_splash: ^2.4.0
- video_thumbnail: ^0.5.3
- flutter_config: ^2.0.2
- flutter_launcher_icons: ^0.13.1
- carousel_slider: ^4.2.1
- flutter_config: ^2.0.2
- smooth_page_indicator: ^1.1.0
- external_path: ^1.0.3
- url_launcher: ^6.2.6
- webview_flutter: ^4.7.0

### 2.2.4 IDE

- Anroid Studio: ^latest_version
- Visual Studio Code: ^latest_version

## 2.3 BACK

- jdk: 17.0.10
- Gradle: 7.5
- Spring Boot : 3.2.3
- Spring Security: 6.2.2
- Spring Data JPA: 3.2.3
- Spring Quartz : 3.2.3
- spring-cloud-start-aws: 2.2.6
- lombok: 1.18.30
- Log4j2: 2.21.1
- QueryDsl : 5.0.0
- Firebase : 9.2.0

## 2.4 DEVELOP TOOL

- Visual Studio Code
- IntelliJ IDE
- AWS EC2
- AWS S3

# 3. 환경 변수 설정 파일 목록

## 3.1 Back

- ~/env/backend/.env

```bash
KAKAO_INSTRUCTOR_CLINET_SECRET=
KAKAO_INSTRUCTOR_REDIRECT_URI=

KAKAO_STUDENT_CLIENT_ID=
KAKAO_STUDENT_CLINET_SECRET=
KAKAO_STUDENT_REDIRECT_URI=

MYSQL_URL=
MYSQL_USERNAME=
MYSQL_PASSWORD=

REDIS_HOST=
REDIS_PASSWORD=
REDIS_PORT=

ACCESS_SECRET_KEY=
REFRESH_SECRET_KEY=

AWS_S3_ACCESS_KEY=
AWS_S3_SECRET_KEY=

# kakao pay
TEST_CID=
PAY_CLIENT_ID=
PAY_CLIENT_SECRET=
PAY_SECRET_KEY=
PAY_SECRET_KEY_DEV=

APPROVAL_URL=
CANCEL_URL=
FAIL_URL=

# fcm
PROJECT_ID=

# codeF
CODEF_CLIENT_ID=
CODEF_CLIENT_SECRET=
CODEF_KEY=
```

- ~/env/backend/goSkiAccountKey.json

```json
{
  "type": "",
  "project_id": "",
  "private_key_id": "",
  "private_key": "",
  "client_id": "",
  "auth_uri": "",
  "token_uri": "",
  "auth_provider_x509_cert_url": "",
  "client_x509_cert_url": "",
  "universe_domain": ""
}
```

- ~/env/backend/ goSkiAccountKey_instructor.json

```json
{
  "type": "",
  "project_id": "",
  "private_key_id": "",
  "private_key": "",
  "client_email": "",
  "client_id": "",
  "auth_uri": "",
  "token_uri": "",
  "auth_provider_x509_cert_url": "",
  "client_x509_cert_url": "",
  "universe_domain": ""
}
```

## 3.2 Front

### 3.2.1 goski_student

```dart
// goski_student/.env
KAKAO_API_KEY=
ANDROID_KAKAO_API_KEY=
BASE_URL=
ACCESS_TOKEN_KEY=
REFRESH_TOKEN_KEY=
FCM_TOKEN_KEY=
OPEN_WEATHER_API_KEY=
```

```dart
// goski_student/android/app/google-services.json
{
  "project_info": {
    "project_number": "870208891269",
    "project_id": "goski-student",
    "storage_bucket": "goski-student.appspot.com"
  },
  "client": [
    {
      "client_info": {
        "mobilesdk_app_id": ",
        "android_client_info": {
          "package_name": "com.example.goski_student"
        }
      },
      "oauth_client": [],
      "api_key": [
        {
          "current_key": 
        }
      ],
      "services": {
        "appinvite_service": {
          "other_platform_oauth_client": []
        }
      }
    }
  ],
  "configuration_version": "1"
}
```

### 3.2.2 goski_instructor

```dart
// goski_student/.env
KAKAO_API_KEY=
ANDROID_KAKAO_API_KEY=
BASE_URL=
ACCESS_TOKEN_KEY=
REFRESH_TOKEN_KEY=
```

```dart
// goski_instructor/android/app/google-services.json
{
  "project_info": {
    "project_number": "870373914042",
    "project_id": "goski-instructor",
    "storage_bucket": "goski-instructor.appspot.com"
  },
  "client": [
    {
      "client_info": {
        "mobilesdk_app_id": ,
        "android_client_info": {
          "package_name": "com.example.goski_instructor"
        }
      },
      "oauth_client": [],
      "api_key": [
        {
          "current_key": 
        }
      ],
      "services": {
        "appinvite_service": {
          "other_platform_oauth_client": []
        }
      }
    }
  ],
  "configuration_version": "1"
}
```

# 4. 서버 기본 설정하기

서비스는 모든 서버가 하나의 환경 위에서 돌아가도록 설계되었다.

## 4.1 서버 시간 설정

```bash
sudo timedatectl set-timezone Asia/Seoul
```

## 4.2 미러 서버 카카오 서버로 변경

패키지 다운을 빠르게 하기 위함.

```bash
sudo sed -i 's/ap-northeast-2.ec2.archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
```

## 4.3 패키지 목록 업데이트 및 패키지 업데이트

```bash
sudo apt-get -y update && sudo apt-get -y upgrade
```

## 4.4 SWAP 영역 할당

```bash
//용량 확인
free -h

//스왑영역 할당
sudo fallocate -l 4G /swapfile

//swapfile 관한 수정
sudo chmode 600 /swapfile

//swapfile 생성
sudo mkswap /swapfile

//swapfile 활성화
sudo swapon /swapfile

//시스템 재부팅 되어도 swap 유지할수 있도록 설정.
sudo echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

//swap 영역 할당 되었는지 확인
free -h
```

# 5. 방화벽 열기

포트번호 : `22`,`80`,`443`,`8080`

```bash
sudo ufw allow {포트번호}
sudo ufw enable
sudo ufw reload
sudo ufw status
```

# 6. 필요한 리소스 설치하기

## 6.1 Java 설치

```bash
sudo apt-get install openjdk-17-jdk

# 자바 환경변수 설정하기
vi /etc/profile

# 가장 아래 쪽에 해당 내용 추가
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=$JAVA_HOME/jre/lib:$JAVA_HOME/lib/tools.jar

# 변경내용 적용하기
source /etc/profile
```

## 6.2 도커 설치

### 6.2.1 Docker 설치 전 필요한 패키지 설치

```bash
sudo apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
```

### 6.2.2 Docker에 대한 GPC Key 인증 진행.

OK가 떴다면 정상적으로 등록된 것.

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

### 6.2.3 Docker 저장소 등록

```bash
sudo add-apt-repossudo apt-get -y install docker-ce docker-ce-cli containerd.ioitory "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```

### 6.2.3 패키지 리스트 갱신

```bash
sudo apt-get -y update
```

### 6.2.4 **Docker 패키지 설치**

```bash
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
```

### 6.2.5 Docker 일반유저에게 권한부여

```bash
sudo usermod -aG docker ubuntu
```

### 6.2.6 Docker 서비스 실행

```bash
sudo service docker restart
```

### 6.2.7 Docker Compose 설치

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/v2.21.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

### 6.2.8 Docker Compose 실행 권한추가

```bash
sudo chmod +x /usr/local/bin/docker-compose
```

## 6.3 Redis 설치(in Docker)

### 6.3.1 redis 네트워크 생성

```bash
sudo docker network create redis-net
```

### 6.3.2 redis 이미지 가져오기

```bash
sudo docker pull redis
```

### 6.3.3 redis 실행

```bash
sudo docker run --name redis-server -p 6379:6379 --network redis-net -d redis redis-server --appendonly yes --requirepass {비밀번호}
```

### 6.3.4 redis 서버 접속

```bash
sudo docker exec -it redis-server redis-cli -a "{비밀번호}"
```

## 6.4 mariaDB 설치(in Docker)

### 6.4.1 mariaDB 이미지 가져오기

```bash
sudo docker pull mariadb:latest
```

### 6.4.2 mariaDB 실행

```bash
sudo docker run -d --restart always -p 3306:3306 -e MYSQL_ROOT_PASSWORD={비밀번호} -e TZ=Asia/Seoul -v /var/lib/mysql:/var/lib/mysql --name mariadb mariadb
```

### 6.4.3 mariaDB 비밀번호 설정

```bash
sudo docker exec -it mariadb bin/bash
mariadb -u root -p
use mysql

GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '{비밀번호}';
```

### 6.4.4 mariaDB 패킷 크기 늘려주기

- 여기서부터 workbench를 이용해서 쿼리문을 실행

```bash
SET GLOBAL max_allowed_packet = 16 * 1024 * 1024;
```

### 6.4.5 database 생성

```sql
create database ski;
```

## 6.5 NginX 설정

### 6.5.1 nginx 설치

```bash
sudo apt install nginx
```

### 6.5.2 nginx 실행

```bash
sudo service nginx start
sudo service nginx status
```

### 6.5.3 리버시 프록시 설정하기

```bash
sudo vi /etc/nginx/sites-available/service.conf

# 아래 내용 작성
server {
  listen 80;
  server_name {서버이름};

  location /api/v1 {
    proxy_pass {백엔드 프로토콜://도메인이름:포트};
  }
}

# service.conf를 적용하기 위해선 default를 먼저 지워야함
sudo rm /etc/nginx/sites-enabled/default

# 작성한 service.conf 적용하기
sudo ln -s /etc/nginx/sites-available/service.conf /etc/nginx/sites-enabled/service.conf

sudo service nginx reload
```

### 6.5.4 https 적용하기(webroot 방식)

```bash
sudo vi /etc/nginx/sites-available/service.conf

# 아래 내용 추가
location ^~ /.well-known/acme-challenge/ {
  default_type "text/plain";
  root /var/www/letsencrypt;
}

# 폴더 생성
sudo mkdir -p /var/www/letsencrypt
cd /var/www/letsencrypt
sudo mkdir -p .well-known/acme-challenge
sudo service nginx reload

# 인증서 발급
sudo certbot certonly --webroot
# 도메인과 root(/var/www/letsencrypt)를 입력해준다

# conf 파일을 다시 수정해준다
sudo vim /etc/nginx/sites-available/service.conf

server {
  listen 80;
  return 301 https://$host$request_uri;
}

server {
  listen 443;
  server_name {서버이름};

  ssl on;
  ssl_certificate /etc/letsencrypt/live/{도메인이름}/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/{도메인이름}/privkey.pem;

  location /api/v1 {
    proxy_pass {백엔드 프로토콜://도메인이름:포트};
  }

  location ^~ /.well-known/acme-challenge/ {
    default_type "text/plain";
    root /var/www/letsencrypt;
  }

  client_max_body_size 2000M;
}

sudo service nginx reload
```

## 6.6 AWS S3 버킷 생성

### 6.6.1 S3 의존성 추가

```json
// build.gradle
...
implementation 'com.google.firebase:firebase-admin:9.2.0'
...
```

### 6.6.2 yml 파일에 환경변수 추가

```bash
# application-s3.yml 파일 생성
cloud:
  aws:
    s3:
      bucket: go-ski
    region:
      static: ap-northeast-2
      auto: false
    stack:
      auto: false
    credentials:
      access-key: ${AWS_S3_ACCESS_KEY}
      secret-key: ${AWS_S3_SECRET_KEY}

```

### 6.6.2 [S3Config.java](http://S3Config.java) 추가

```java
package com.go.ski.config;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class S3Config {

    @Value("${cloud.aws.credentials.access-key}")
    private String accessKey;

    @Value("${cloud.aws.credentials.secret-key}")
    private String secretKey;

    @Value("${cloud.aws.region.static}")
    private String region;

    @Bean
    public AmazonS3Client amazonS3Client() {
        BasicAWSCredentials awsCredentials =new BasicAWSCredentials(accessKey, secretKey);
        return(AmazonS3Client) AmazonS3ClientBuilder.standard()
                .withRegion(region)
                .withCredentials(new AWSStaticCredentialsProvider(awsCredentials))
                .build();
    }
}
```

## 6.7 Jenkins 설치

### 6.7.1 시스템에 젠킨스 레포지토리 추가

```bash
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
```

### 6.7.2 apt 업데이트

```bash
sudo apt update
```

### 6.7.3 젠킨스 설치

```bash
sudo apt install jenkins
```

### 6.7.3 젠킨스 백엔드 파이프라인

```bash
pipeline {
    agent any

    stages {
        stage('start') {
            steps{
                mattermostSend channel: '{젠킨스 매터모스트 채널명}', endpoint: '{매터모스트 url}', message: ':hi_manggom: Backend Release Start :hi_manggom:'
            }
        }
        
        stage('git clone') {
            steps {
                git branch: '{브랜치명}', credentialsId: '{젠킨스 인증 id}', url: '{깃 레포지토리 url}'
            }
        }
        
        stage('create env') {
            steps {
                sh'''
                    cp /home/ubuntu/env/backend/.env /var/lib/jenkins/workspace/GoskiBackend/backend
                    cp /home/ubuntu/env/backend/goSkiAccountKey.json /var/lib/jenkins/workspace/GoskiBackend/backend/src/main/resources
                    cp /home/ubuntu/env/backend/goSkiAccountKey_instructor.json /var/lib/jenkins/workspace/GoskiBackend/backend/src/main/resources
                '''
            }
        }
        
        stage('build') {
            steps {
                dir('backend'){
                    sh'''
                        chmod +x ./gradlew
                        ./gradlew wrapper --gradle-version=7.5 --distribution-type=bin
                        ./gradlew clean bootJar
                    '''
                }
            }
        }
        
        stage('stop & rm container') {
            steps {
                dir('backend'){
                    sh'''
                        # 컨테이너가 실행 중인지 확인
                        if docker ps -a --filter "name=goski-backend" --format '{{.Names}}' 2>/dev/null | grep -q goski-backend; then
                            echo "컨테이너 'goski-backend'가 실행 중입니다."
                            docker stop goski-backend
                            docker rm goski-backend
                        else
                            echo "컨테이너 'goski-backend'가 실행 중이 아닙니다."
                        fi
                        
                        # 이미지가 존재하는지 확인
                        if docker images -a --format '{{.Repository}}:{{.Tag}}' | grep -q goski-backend; then
                            echo "이미지 'goski-backend'가 존재합니다."
                            docker rmi goski-backend
                        else
                            echo "이미지 'goski-backend'가 존재하지 않습니다."
                        fi
                    '''
                }
            }
        }
        
        stage('deploy') {
            steps {
                dir('backend'){
                    sh'''
                        docker build -t goski-backend:latest .
                        docker run -i -t -p 8081:8081 --env-file .env -d --name goski-backend -e TZ=Asia/Seoul goski-backend:latest
                    '''
                }
            }
        }
    }
    
    post {
        success {
        	script {
                mattermostSend (color: 'good', 
                message: ":manggom_3: Backend Realease Complete :manggom_3:", 
                endpoint: '{매터모스트 url}', 
                channel: '{젠킨스 매터모스트 채널명}'
                )
            }
        }
        failure {
        	script {
                mattermostSend (color: 'danger', 
                message: ":manggom_2: Backend Realease Fail :manggom_2:", 
                endpoint: '{매터모스트 url}', 
                channel: '{젠킨스 매터모스트 채널명}'
                )
            }
        }
    }
}
```

## 6.8 Front

### 6.8.1 Flutter android licenses

```dart
// flutter 설치 후 cmd에서 다음 명령어 실행
flutter doctor --anrdoid-licenses
// 이후 모두 y
```

### 6.8.2 Android keystore

- 안드로이드 인증서 생성

```dart
// 생성 명령어(/android/app 폴더에서 cmd)
keytool -genkey -v -keystore {app_name}-release-key.keystore -alias {app_name}-key-alias -keyalg RSA -keysize 2048 -validity 10000

// 서명키 확인 명령어
keytool -list -v -keystore {app_name}-release-key.keystore
```

### 6.8.3 Android Hash Key

```dart
// cmd 아무 경로에서
keytool -exportcert -alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore -storepass android -keypass android | openssl sha1 -binary | openssl base64
```

# 7. 프로젝트 실행

## 7.0 Project Clone

```dart
git clone ${our_gitlab_link}
```

## 7.1 Front

### 7.1.1 .apk File Build

- Visual Studio Code or Anroid Studio, IDE를 활용하여 release mode로 실행

### 7.1.2 .apk File Download

- goski_instructor/build/app/outputs/apk/release 경로의 .apk 파일 다운로드