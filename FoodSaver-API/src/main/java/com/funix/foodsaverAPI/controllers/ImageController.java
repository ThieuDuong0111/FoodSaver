package com.funix.foodsaverAPI.controllers;

import java.util.Base64;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.funix.foodsaverAPI.models.Banner;
import com.funix.foodsaverAPI.models.Category;
import com.funix.foodsaverAPI.models.MyUser;
import com.funix.foodsaverAPI.models.OrderDetail;
import com.funix.foodsaverAPI.models.Product;
import com.funix.foodsaverAPI.services.BannerServiceImpl;
import com.funix.foodsaverAPI.services.CategoryServiceImpl;
import com.funix.foodsaverAPI.services.OrderDetailServiceImpl;
import com.funix.foodsaverAPI.services.ProductServiceImpl;
import com.funix.foodsaverAPI.services.UserServiceImpl;

@RestController
@RequestMapping("/api/image")
public class ImageController {

	@Autowired
	private UserServiceImpl userServiceImpl;

	@Autowired
	private ProductServiceImpl productServiceImpl;

	@Autowired
	private CategoryServiceImpl categoryServiceImpl;

	@Autowired
	private BannerServiceImpl bannerServiceImpl;

	@Autowired
	private OrderDetailServiceImpl orderDetailServiceImpl;

	@GetMapping("/user/{url}")
	public ResponseEntity<?> getImageUserById(
		@PathVariable("url") String url) {
		MyUser user = userServiceImpl.getUserByImageUrl(url);
		byte[] image = Base64.getDecoder()
			.decode(user.getAvatar());
		return ResponseEntity.status(HttpStatus.OK)
			.contentType(MediaType.valueOf(user.getImageType()))
			.body(image);
	}

	@GetMapping("/category/{url}")
	public ResponseEntity<?> getImageCategoryById(
		@PathVariable("url") String url) {
		Category category = categoryServiceImpl.getCategoryByImageUrl(url);
		byte[] image = Base64.getDecoder().decode(category.getImage());
		return ResponseEntity.status(HttpStatus.OK)
			.contentType(MediaType.valueOf(category.getImageType()))
			.body(image);
	}

	@GetMapping("/product/{url}")
	public ResponseEntity<?> getImageProductById(
		@PathVariable("url") String url) {
		Product product = productServiceImpl.getProductByImageUrl(url);
		byte[] image = Base64.getDecoder()
			.decode(product.getImage());
		return ResponseEntity.status(HttpStatus.OK)
			.contentType(MediaType.valueOf(product.getImageType()))
			.body(image);
	}

	@GetMapping("/banner/{url}")
	public ResponseEntity<?> getBannerById(
		@PathVariable("url") String url) {
		Banner banner = bannerServiceImpl.getBannerByImageUrl(url);
		byte[] image = Base64.getDecoder()
			.decode(banner.getImage());
		return ResponseEntity.status(HttpStatus.OK)
			.contentType(MediaType.valueOf(banner.getImageType()))
			.body(image);
	}

	@GetMapping("/order/{id}/{url}")
	public ResponseEntity<?> getImageOrderById(
		@PathVariable("url") String url,
		@PathVariable("id") int id) {
		OrderDetail orderDetail = orderDetailServiceImpl.getOrderDetailById(id);
		byte[] image = Base64.getDecoder()
			.decode(orderDetail.getImage());
		return ResponseEntity.status(HttpStatus.OK)
			.contentType(MediaType.valueOf(orderDetail.getImageType()))
			.body(image);
	}

}
