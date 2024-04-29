package com.go.ski.team.core.model;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Entity
@Builder
@AllArgsConstructor
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED )
public class TeamImage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer teamImageId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="team_id")
    @OnDelete(action = OnDeleteAction.CASCADE)
    private Team team;

    @Column(nullable = false)
    private String imageUrl;

    public void updateTeamImage(String teamImageUrl) {
        this.imageUrl = teamImageUrl;
    }

}
