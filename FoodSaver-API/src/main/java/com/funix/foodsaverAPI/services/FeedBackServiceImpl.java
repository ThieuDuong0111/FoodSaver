package com.funix.foodsaverAPI.services;

import java.util.Date;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.funix.foodsaverAPI.dto.AddFeedBackDTO;
import com.funix.foodsaverAPI.dto.FeedBackDTO;
import com.funix.foodsaverAPI.models.FeedBack;
import com.funix.foodsaverAPI.repositories.IFeedBackRepository;
import com.funix.foodsaverAPI.repositories.IProductRepository;
import com.funix.foodsaverAPI.repositories.IUserRepository;

@Service
public class FeedBackServiceImpl implements IFeedBackService {

	@Autowired
	private IFeedBackRepository feedBackRepository;

	@Autowired
	private IProductRepository productRepository;

	@Autowired
	private IUserRepository userRepository;

	@Autowired
	private ModelMapper modelMapper;

	@Override
	public FeedBackDTO convertToDto(FeedBack feedBack) {
		return modelMapper.map(feedBack, FeedBackDTO.class);
	}

	@Override
	public void addFeedBack(AddFeedBackDTO addFeedBackDTO) {
		FeedBack feed = new FeedBack(
			userRepository.findById(addFeedBackDTO.getUserId()).get(),
			productRepository.findById(addFeedBackDTO.getProductId()).get(),
			addFeedBackDTO.getComment(),
			addFeedBackDTO.getRating(),
			new Date());
		feedBackRepository.save(feed);
	}

	@Override
	public List<FeedBackDTO> getFeedBacksByProductId(int productId) {
		return feedBackRepository.findByProductId(productId).stream()
			.map(this::convertToDto).toList();
	}
}
