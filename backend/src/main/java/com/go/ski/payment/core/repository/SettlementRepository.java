package com.go.ski.payment.core.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.go.ski.payment.core.model.Settlement;
import com.go.ski.payment.support.dto.response.RecentSettlementRecordResponseDTO;
import com.go.ski.payment.support.dto.response.WithdrawalResponseDTO;
import com.go.ski.payment.support.dto.util.TotalSettlementDTO;

public interface SettlementRepository extends JpaRepository<Settlement, Integer> {

	@Query("SELECT new com.go.ski.payment.support.dto.response.WithdrawalResponseDTO ( "
		+ "s.settlementAmount, s.balance, s.settlementDate "
		+ ") "
		+ "FROM Settlement s "
		+ "WHERE s.user.userId = :userId ")
	List<WithdrawalResponseDTO> findWithrawalList(Integer userId);

	@Query("SELECT new com.go.ski.payment.support.dto.util.TotalSettlementDTO ( "
		+ "s.settlementAmount ) "
		+ "FROM Settlement s "
		+ "WHERE s.user.userId = :userId " )
	List<TotalSettlementDTO> findBySettlements (Integer userId);

	Settlement findByUserUserId(Integer userId);

	@Query("SELECT new com.go.ski.payment.support.dto.response.RecentSettlementRecordResponseDTO ( "
		+ "s.balance )"
		+ "FROM Settlement s "
		+ "WHERE s.user.userId = :userId "
		+ "ORDER BY s.settlementDate DESC, s.settlementId DESC "
		+ "LIMIT 1 ")
	RecentSettlementRecordResponseDTO findRecentBalance(Integer userId);
}
