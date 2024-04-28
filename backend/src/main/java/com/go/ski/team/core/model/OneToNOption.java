package com.go.ski.team.core.model;

import com.go.ski.team.support.dto.TeamCreateRequestDTO;
import com.go.ski.team.support.dto.TeamUpdateRequestDTO;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "one_to_n_option")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@ToString
public class OneToNOption {

    @Id
    private Integer teamId;

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

    @Column(name="one_n_fee",nullable = false)
    private Integer oneNFee;

    public static OneToNOption createOneToNOption(Team team, TeamCreateRequestDTO requestDTO) {
        OneToNOption oneToNOption = new OneToNOption();
        oneToNOption.team = team;
        oneToNOption.oneTwoFee = requestDTO.getOneTwoFee();
        oneToNOption.oneThreeFee = requestDTO.getOneThreeFee();
        oneToNOption.oneFourFee = requestDTO.getOneFourFee();
        oneToNOption.oneNFee = requestDTO.getOneNFee();
        return oneToNOption;
    }

    public void update(TeamUpdateRequestDTO requestDTO) {
        this.oneTwoFee = requestDTO.getOneTwoFee();
        this.oneThreeFee = requestDTO.getOneThreeFee();
        this.oneFourFee = requestDTO.getOneFourFee();
        this.oneNFee = requestDTO.getOneNFee();
    }


}
