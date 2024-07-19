package com.funix.foodsaverAPI.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.funix.foodsaverAPI.services.UserServiceImpl;

@RestController
@RequestMapping("/api")
public class StoreController {

	@Autowired
	private UserServiceImpl userServiceImpl;

	@GetMapping({ "/store/all" })
	public ResponseEntity<?> getAllStores() {

		return ResponseEntity.ok(userServiceImpl.getAllStores());
	}
}
