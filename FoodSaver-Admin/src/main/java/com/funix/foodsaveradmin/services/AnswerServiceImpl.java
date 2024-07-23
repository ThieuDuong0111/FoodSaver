package com.funix.foodsaveradmin.services;

import java.util.Date;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.funix.foodsaveradmin.dto.AnswerDTO;
import com.funix.foodsaveradmin.models.Answer;
import com.funix.foodsaveradmin.repositories.IAnswerRepository;

@Service
public class AnswerServiceImpl implements IAnswerService {

	@Autowired
	private IAnswerRepository answerRepository;

	@Autowired
	private ModelMapper modelMapper;

	@Override
	public Answer convertToEntity(AnswerDTO answerDTO) {
		return modelMapper.map(answerDTO, Answer.class);
	}

	@Override
	public AnswerDTO convertToDto(Answer Answer) {
		return modelMapper.map(Answer, AnswerDTO.class);
	}

	@Override
	public Page<Answer> findPaginated(int pageNum, int pageSize,
		String sortField, String sortDirection, int feedbackId) {
		Sort sort = sortDirection.equalsIgnoreCase(Sort.Direction.ASC.name())
			? Sort.by(sortField).ascending()
			: Sort.by(sortField).descending();

		Pageable pageable = PageRequest.of(pageNum - 1, pageSize, sort);
		return this.answerRepository.findAllByFeedbackId(feedbackId, pageable);
	}

	@Override
	public void saveAnswer(AnswerDTO answerDTO) {
		answerDTO.setIsCreator(true);
		answerDTO.setPublishedDate(new Date());
		this.answerRepository.save(convertToEntity(answerDTO));
	}
}
