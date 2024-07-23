package com.funix.foodsaveradmin.repositories;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.funix.foodsaveradmin.models.Answer;

public interface IAnswerRepository extends JpaRepository<Answer, Integer> {
	@Query(value = "SELECT * FROM Answer a WHERE a.feedback_id = :feedback_id", nativeQuery = true)
	Page<Answer> findAllByFeedbackId(@Param("feedback_id") int feedbackId,
		Pageable pageable);
}
