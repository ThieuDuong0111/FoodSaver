package com.funix.foodsaverAPI.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.funix.foodsaverAPI.dto.HomeDTO;
import com.funix.foodsaverAPI.services.BannerServiceImpl;
import com.funix.foodsaverAPI.services.CategoryServiceImpl;
import com.funix.foodsaverAPI.services.ProductServiceImpl;
import com.funix.foodsaverAPI.services.UserServiceImpl;

@RestController
@RequestMapping("/api/home")
public class HomeController {

	@Autowired
	private BannerServiceImpl bannerServiceImpl;
	
	@Autowired
	private UserServiceImpl userServiceImpl;
	
	@Autowired
	private CategoryServiceImpl categoryServiceImpl;

	@Autowired
	private ProductServiceImpl productServiceImpl;

	@GetMapping
	public ResponseEntity<?> getHome() {
		HomeDTO homeDTO = new HomeDTO();
		homeDTO.setBanners(bannerServiceImpl.getAllBanners());
		homeDTO.setCategories(categoryServiceImpl.getAllCategories());
		homeDTO.setStores(userServiceImpl.get10NewestStore());
		homeDTO.setMostRatingProducts(productServiceImpl.getTop5MostPurchaseProducts());
		homeDTO.setNewestProducts(productServiceImpl.getTop20NewestProducts());
		return ResponseEntity.ok(homeDTO);
	}
}
