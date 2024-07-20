package com.funix.foodsaveradmin.services;

import java.util.List;

import org.springframework.data.domain.Page;

import com.funix.foodsaveradmin.dto.BannerDTO;
import com.funix.foodsaveradmin.models.Banner;

public interface IBannerService {

	BannerDTO convertToDto(Banner Banner);

	Banner convertToEntity(BannerDTO BannerDTO);

	List<Banner> getAllBanners();

	void saveBanner(BannerDTO BannerDTO);

	Banner getBannerById(int id);

	void deleteBannerById(int id);
	
	Page<Banner> findPaginated(int pageNum, int pageSize,
		String sortField,
		String sortDirection);

}
