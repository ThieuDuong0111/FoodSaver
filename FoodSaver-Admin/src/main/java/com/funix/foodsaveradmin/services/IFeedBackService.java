package com.funix.foodsaveradmin.services;

import java.util.List;


import com.funix.foodsaveradmin.dto.FeedBackDTO;
import com.funix.foodsaveradmin.models.FeedBack;

public interface IFeedBackService {

	FeedBackDTO convertToDto(FeedBack feedBack);

	List<FeedBack> findPaginated(int pageNum, int pageSize,
		String sortField,
		String sortDirection, int creatorId);
}
