package com.funix.foodsaveradmin.services;

import org.springframework.data.domain.Page;

import com.funix.foodsaveradmin.dto.AnswerDTO;
import com.funix.foodsaveradmin.models.Answer;

public interface IAnswerService {

	Answer convertToEntity(AnswerDTO answerDTO);

	AnswerDTO convertToDto(Answer answer);

	Page<Answer> findPaginated(int pageNum, int pageSize,
		String sortField,
		String sortDirection,
		int feedBackId);

	void saveAnswer(AnswerDTO answerDTO);

}
