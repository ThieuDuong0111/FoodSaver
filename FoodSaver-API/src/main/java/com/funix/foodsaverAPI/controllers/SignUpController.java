package com.funix.foodsaverAPI.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.funix.foodsaverAPI.dto.SignUpDTO;
import com.funix.foodsaverAPI.services.UserServiceImpl;

@RestController
@RequestMapping("/api")
public class SignUpController {

	@Autowired
	private UserServiceImpl userServiceImpl;

	@PostMapping("/sign-up")
	public ResponseEntity<?> signUpUser(@RequestBody SignUpDTO signUpDTO) {
		// check null or empty
		if (userServiceImpl.checkInformationSignUpValid(signUpDTO)
			.getHasError() == true) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
				.body(signUpDTO);
		}
		// add check for username exists in a DB
		if (userServiceImpl.existsByNameSignUp(signUpDTO).getHasError() == true) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
				.body(signUpDTO);
		}
		// add check for email exists in DB
		if (userServiceImpl.existsByEmailSignUp(signUpDTO).getHasError() == true) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
				.body(signUpDTO);
		}
		// add check for email exists in DB
		if (userServiceImpl.existsByEmailSignUp(signUpDTO).getHasError() == true) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
				.body(signUpDTO);
		}

		userServiceImpl.signUp(signUpDTO);

		return new ResponseEntity<>("User registered successfully",
			HttpStatus.OK);
	}
}
