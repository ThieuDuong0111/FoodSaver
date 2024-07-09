package com.funix.foodsaverAPI.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.funix.foodsaverAPI.dto.UserDTO;
import com.funix.foodsaverAPI.models.MyUser;
import com.funix.foodsaverAPI.services.UserServiceImpl;

import jakarta.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/api/user")
public class UserController {

	@Autowired
	private UserServiceImpl userServiceImpl;

	@GetMapping("/user-info")
	public ResponseEntity<?> getUserInfo(HttpServletRequest request) {
		MyUser user = userServiceImpl.getUserByToken(request);
		return ResponseEntity
			.ok(userServiceImpl.convertToDto(user));
	}

	@PutMapping(path = "/update-info", consumes = {
		MediaType.MULTIPART_FORM_DATA_VALUE })
	public ResponseEntity<?> updateUserInfo(HttpServletRequest request,
		@ModelAttribute UserDTO userDTO) {
		UserDTO responseUserDTO = userServiceImpl.updateUserInfo(request,
			userDTO);
		return ResponseEntity.ok(responseUserDTO);
	}
}
