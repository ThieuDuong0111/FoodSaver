package com.funix.foodsaverAPI.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.funix.foodsaverAPI.dto.SignInDTO;
import com.funix.foodsaverAPI.dto.TokenDTO;
import com.funix.foodsaverAPI.services.JWTService;
import com.funix.foodsaverAPI.services.UserServiceImpl;

@RestController
@RequestMapping("/api")
public class SignInController {

	@Autowired
	private JWTService jWTService;

	@Autowired
	private UserServiceImpl userServiceImpl;

	@Autowired
	private AuthenticationManager authenticationManager;

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
			new TokenDTO(authenticateAndGetToken(signInDTO)),
			HttpStatus.OK);
	}

	public String authenticateAndGetToken(
		SignInDTO signInDTO) {
		Authentication authentication = authenticationManager
			.authenticate(new UsernamePasswordAuthenticationToken(
				signInDTO.getName(), signInDTO.getPassword()));
		if (authentication.isAuthenticated()) {
			return jWTService.generateToken(signInDTO.getName());
		} else {
			throw new UsernameNotFoundException("Invalid user request!");
		}
	}
}
