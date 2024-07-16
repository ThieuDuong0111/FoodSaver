package com.funix.foodsaveradmin.services;

import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
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
	public List<FeedBack> findPaginated(int pageNum, int pageSize,
		String sortField, String sortDirection, int creatorId) {
//		Sort sort = sortDirection.equalsIgnoreCase(Sort.Direction.ASC.name())
//			? Sort.by(sortField).ascending()
//			: Sort.by(sortField).descending();

//		Pageable pageable = PageRequest.of(pageNum - 1, pageSize, sort);
		return this.feedBackRepository.findAllByCreatorId(creatorId);
	}

}
