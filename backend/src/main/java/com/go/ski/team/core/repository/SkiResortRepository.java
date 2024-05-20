package com.go.ski.team.core.repository;

import java.util.List;

import com.go.ski.team.core.model.SkiResort;
import com.go.ski.team.support.dto.ResortListDTO;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

public interface SkiResortRepository extends JpaRepository<SkiResort, Integer> {

	@Query("SELECT new com.go.ski.team.support.dto.ResortListDTO ( "
		+ "s.resortId, s.resortLocation, s.resortName, s.latitude, s.longitude, GROUP_CONCAT(lt.lessonTime) "
		+ ") "
		+ "FROM SkiResort s "
		+ "JOIN LessonTime lt ON s.resortId = lt.skiResort.resortId "
		+ "GROUP BY s.resortId, s.resortLocation, s.resortName")
	List<ResortListDTO> findResortList();
}
