package com.funix.foodsaveradmin.services;


import org.springframework.data.domain.Page;

import com.funix.foodsaveradmin.dto.FeedBackDTO;
import com.funix.foodsaveradmin.models.FeedBack;

public interface IFeedBackService {

	FeedBackDTO convertToDto(FeedBack feedBack);

	Page<FeedBack> findPaginated(int pageNum, int pageSize,
		String sortField,
		String sortDirection);

	Page<FeedBack> findAllByCreatorIdPagination(int pageNum, int pageSize,
		String sortField,
		String sortDirection,
		int creatorId);
}
