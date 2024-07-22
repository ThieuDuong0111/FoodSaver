package com.funix.foodsaverAPI.services;

import java.util.List;

import com.funix.foodsaverAPI.dto.SignInDTO;
import com.funix.foodsaverAPI.dto.SignUpDTO;
import com.funix.foodsaverAPI.dto.UserDTO;
import com.funix.foodsaverAPI.models.MyUser;

import jakarta.servlet.http.HttpServletRequest;

public interface IUserService {

	UserDTO convertToDto(MyUser user);

	MyUser convertToEntity(UserDTO userDTO);

	List<MyUser> getAllUsers();
	
	List<UserDTO> getAllStores();
	
	List<UserDTO> get10NewestStore();

	UserDTO updateUserInfo(HttpServletRequest request, UserDTO userDTO);
	
	UserDTO updateUserInfoMobile(HttpServletRequest request, UserDTO userDTO);

	MyUser getUserById(int id);

	MyUser getUserByName(String name);

	MyUser getUserByImageUrl(String url);
	
	MyUser getUserByStoreImageUrl(String url);

	MyUser getUserByToken(HttpServletRequest request) throws IllegalArgumentException;

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
