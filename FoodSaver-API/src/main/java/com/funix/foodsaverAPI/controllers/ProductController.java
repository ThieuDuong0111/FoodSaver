package com.funix.foodsaverAPI.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.funix.foodsaverAPI.dto.ProductDTO;
import com.funix.foodsaverAPI.services.ProductServiceImpl;

@RestController
@RequestMapping("/api")
public class ProductController {

	@Autowired
	private ProductServiceImpl productServiceImpl;

	@GetMapping({ "/products/all" })
	public ResponseEntity<?> getAllProducts() {
		return ResponseEntity.ok(productServiceImpl.getAllProducts());
	}

	@GetMapping({ "/product/{id}" })
	public ResponseEntity<?> getProductDetail(@PathVariable int id) {
		ProductDTO productDTO = productServiceImpl
			.convertToDto(productServiceImpl.getProductById(id));
		if (productDTO == null) {
			return ResponseEntity.notFound().build();
		}
		return ResponseEntity.ok(productDTO);
	}

	@GetMapping({ "/products/by-category/{id}" })
	public ResponseEntity<?> getProductByCategoryId(
		@PathVariable int id) {
		return ResponseEntity
			.ok(productServiceImpl.findByCategoryId(id));
	}

	@GetMapping({ "/products/by-store/{id}" })
	public ResponseEntity<?> getProductByStoreId(
		@PathVariable int id) {
		return ResponseEntity
			.ok(productServiceImpl.findByStoreId(id));
	}
}
