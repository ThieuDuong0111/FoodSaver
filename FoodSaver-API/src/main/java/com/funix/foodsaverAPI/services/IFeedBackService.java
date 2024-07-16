package com.funix.foodsaverAPI.services;

import java.util.List;

import com.funix.foodsaverAPI.dto.AddFeedBackDTO;
import com.funix.foodsaverAPI.dto.FeedBackDTO;
import com.funix.foodsaverAPI.models.FeedBack;

public interface IFeedBackService {
	
	FeedBackDTO convertToDto(FeedBack feedBack);

	void addFeedBack(AddFeedBackDTO addFeedBackDTO);

	List<FeedBackDTO> getFeedBacksByProductId(int productId);
}
