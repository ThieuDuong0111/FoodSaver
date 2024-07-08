package com.funix.foodsaverAPI.controllers;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.funix.foodsaverAPI.dto.SignInDTO;
import com.funix.foodsaverAPI.models.MyUser;
import com.funix.foodsaverAPI.services.UserServiceImpl;
import com.funix.foodsaverAPI.utils.JWTUtils;

@RestController
@RequestMapping("/api")
public class SignInController {

	@Autowired
	private UserServiceImpl userServiceImpl;

	@Autowired
	private ModelMapper modelMapper;

	@PostMapping("/sign-in")
	public ResponseEntity<?> signInUser(@RequestBody SignInDTO signInDTO) {
		// check null or empty
		if (userServiceImpl.checkInformationSignInValid(signInDTO)
			.getHasError() == true) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
				.body(signInDTO);
		}

		// add check for username exists in a DB
		if (userServiceImpl.existsByNameSignIn(signInDTO)
			.getHasError() == true) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
				.body(signInDTO);
		}

		// add check password correct
		if (userServiceImpl.validatePasswordSignIn(signInDTO)
			.getHasError() == true) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
				.body(signInDTO);
		}

		return new ResponseEntity<>(
			JWTUtils.createJwtoken(modelMapper.map(signInDTO, MyUser.class)),
			HttpStatus.OK);
	}
}
