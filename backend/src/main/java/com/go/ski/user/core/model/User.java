package com.go.ski.user.core.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.go.ski.notification.core.domain.NotificationSetting;
import com.go.ski.user.support.vo.Gender;
import com.go.ski.user.support.vo.Role;
import com.go.ski.auth.oauth.dto.Domain;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.Check;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import static jakarta.persistence.EnumType.STRING;
import static lombok.AccessLevel.PROTECTED;

@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = PROTECTED)
@Getter
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer userId;

    @Embedded
    private Domain domain;

    @Setter
    private String userName;

    @Setter
    private LocalDate birthDate;

    @Setter
    private String phoneNumber;

    @Setter
    private String profileUrl;

    @Setter
    @Enumerated(STRING)
    private Gender gender;

    @Setter
    @Enumerated(STRING)
    private Role role;

    private String fcmWeb;
    private String fcmMobile;

    private LocalDateTime createdDate;
    @Setter
    private LocalDateTime expiredDate;

//    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
//    private List<NotificationSetting> settingList;

    @PrePersist
    protected void onCreate() {
        createdDate = LocalDateTime.now();
    }

    public void updateFcmWeb(String fcmWeb){
        this.fcmWeb = fcmWeb;
    }

    public void updateFcmMobile(String fcmMobile){
        this.fcmMobile = fcmMobile;
    }

}