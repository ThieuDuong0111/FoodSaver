package com.funix.foodsaverAPI.services;

import java.util.List;

import com.funix.foodsaverAPI.dto.BannerDTO;
import com.funix.foodsaverAPI.models.Banner;

public interface IBannerService {

	BannerDTO convertToDto(Banner Banner);

	List<BannerDTO> getAllBanners();
	
	Banner getBannerByImageUrl(String url);

	Banner getBannerById(int id);

}
