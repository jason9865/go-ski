package com.go.ski.team.core.model;
import com.go.ski.user.core.model.User;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;

import static lombok.AccessLevel.PROTECTED;

@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = PROTECTED)
@Getter
@ToString
public class Team {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY )
    private Integer teamId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "resort_id",nullable = false)
    private SkiResort skiResort;

    @Setter
    @Column(nullable = false)
    private String teamName;

    @Setter
    @Column(nullable = false)
    private String teamProfileUrl;

    @Setter
    @Column(nullable = false)
    private String description;

    @Setter
    @Column(nullable = false)
    private Integer teamCost;

    @Setter
    @Column(nullable = false)
    private Integer dayoff;


}
