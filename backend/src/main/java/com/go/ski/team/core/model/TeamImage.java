package com.go.ski.team.core.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Builder
@AllArgsConstructor
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED )
public class TeamImage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int teamImageId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="team_id")
    private Team team;

    @Column(nullable = false)
    private String imageUrl;

}
