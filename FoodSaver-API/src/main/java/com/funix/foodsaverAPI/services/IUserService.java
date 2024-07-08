package com.funix.foodsaverAPI.services;

import java.util.List;

import com.funix.foodsaverAPI.dto.SignInDTO;
import com.funix.foodsaverAPI.dto.SignUpDTO;
import com.funix.foodsaverAPI.dto.UserDTO;
import com.funix.foodsaverAPI.models.MyUser;

public interface IUserService {

	UserDTO convertToDto(MyUser user);

	MyUser convertToEntity(UserDTO userDTO);

	List<MyUser> getAllUsers();

	void saveUser(UserDTO userDTO);

	MyUser getUserById(int id);

	MyUser getUserByImageUrl(String url);

	// Sign-Up

	SignUpDTO checkInformationSignUpValid(SignUpDTO signUpDTO);

	SignUpDTO existsByNameSignUp(SignUpDTO signUpDTO);

	SignUpDTO existsByEmailSignUp(SignUpDTO signUpDTO);

	SignUpDTO existsByPhoneSignUp(SignUpDTO signUpDTO);

	void signUp(SignUpDTO signUpDTO);

	// Sign-In

	SignInDTO checkInformationSignInValid(SignInDTO ignInDTO);

	SignInDTO existsByNameSignIn(SignInDTO signInDTO);
	
	SignInDTO validatePasswordSignIn(SignInDTO signInDTO);
}
