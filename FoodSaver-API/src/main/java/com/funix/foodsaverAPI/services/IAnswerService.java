package com.funix.foodsaverAPI.services;

import com.funix.foodsaverAPI.dto.AddAnswerDTO;
import com.funix.foodsaverAPI.dto.AnswerDTO;
import com.funix.foodsaverAPI.models.Answer;

public interface IAnswerService {

	AnswerDTO convertToDto(Answer Answer);

	void addAnswer(AddAnswerDTO addAnswerDTO);

}
