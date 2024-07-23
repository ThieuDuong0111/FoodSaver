package com.funix.foodsaverAPI.services;

import java.util.Date;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.funix.foodsaverAPI.dto.AddAnswerDTO;
import com.funix.foodsaverAPI.dto.AnswerDTO;
import com.funix.foodsaverAPI.models.Answer;
import com.funix.foodsaverAPI.models.FeedBack;
import com.funix.foodsaverAPI.models.MyUser;
import com.funix.foodsaverAPI.repositories.IAnswerRepository;

@Service
public class AnswerServiceImpl implements IAnswerService {

	@Autowired
	private IAnswerRepository answerRepository;

	@Autowired
	private ModelMapper modelMapper;

	@Override
	public AnswerDTO convertToDto(Answer Answer) {
		return modelMapper.map(Answer, AnswerDTO.class);
	}

	@Override
	public void addAnswer(AddAnswerDTO addAnswerDTO) {

		FeedBack feedBack = new FeedBack();
		feedBack.setId(addAnswerDTO.getFeedBackId());
		MyUser user = new MyUser();
		user.setId(addAnswerDTO.getUserId());
		Answer answer = new Answer();
		answer.setFeedback(feedBack);
		answer.setUserAnswer(user);
		answer.setIsCreator(false);
		answer.setPublishedDate(new Date());
		answer.setAnswer(addAnswerDTO.getAnswer());

		answerRepository.save(answer);

	}

}
