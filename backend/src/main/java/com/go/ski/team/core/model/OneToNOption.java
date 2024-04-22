package com.go.ski.team.core.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "one_to_n_option")
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@ToString
public class OneToNOption {

    @Id
    private int teamId;

    @MapsId
    @OneToOne
    @JoinColumn(name="team_id")
    private Team team;

    @Column(nullable = false)
    private Integer oneTwoFee;

    @Column(nullable = false)
    private Integer oneThreeFee;

    @Column(nullable = false)
    private Integer oneFourFee;

    @Column(nullable = false)
    private Integer oneNFee;

}
