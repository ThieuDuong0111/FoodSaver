package com.funix.foodsaveradmin.services;

import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.funix.foodsaveradmin.dto.FeedBackDTO;
import com.funix.foodsaveradmin.models.FeedBack;
import com.funix.foodsaveradmin.repositories.IFeedBackRepository;

@Service
public class FeedBackServiceImpl implements IFeedBackService {

	@Autowired
	private IFeedBackRepository feedBackRepository;

	@Autowired
	private ModelMapper modelMapper;

	@Override
	public FeedBackDTO convertToDto(FeedBack feedBack) {
		return modelMapper.map(feedBack, FeedBackDTO.class);
	}

	@Override
	public Page<FeedBack> findPaginated(int pageNum, int pageSize,
		String sortField, String sortDirection) {
		Sort sort = sortDirection.equalsIgnoreCase(Sort.Direction.ASC.name())
			? Sort.by(sortField).ascending()
			: Sort.by(sortField).descending();

		Pageable pageable = PageRequest.of(pageNum - 1, pageSize, sort);
		return this.feedBackRepository.findAll(pageable);
	}

	@Override
	public Page<FeedBack> findAllByCreatorIdPagination(int pageNum,
		int pageSize,
		String sortField,
		String sortDirection, int creatorId) {
		Sort sort = sortDirection.equalsIgnoreCase(Sort.Direction.ASC.name())
			? Sort.by(sortField).ascending()
			: Sort.by(sortField).descending();

		Pageable pageable = PageRequest.of(pageNum - 1, pageSize, sort);
		return this.feedBackRepository.findAllByCreatorIdPagination(creatorId,
			pageable);
	}

	@Override
	public FeedBack getFeedbackById(int feedbackId) {
		Optional<FeedBack> optionalFeedback = feedBackRepository.findById(feedbackId);
		FeedBack feedBack = null;
		if (optionalFeedback.isPresent()) {
			feedBack = optionalFeedback.get();
		} else {
			throw new RuntimeException("Feedback not found for id : " + feedbackId);
		}
		return feedBack;
	}
}
