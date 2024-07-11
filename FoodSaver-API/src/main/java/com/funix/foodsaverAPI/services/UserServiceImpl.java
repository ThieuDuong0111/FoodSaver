package com.funix.foodsaverAPI.services;

import java.util.Base64;
import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.funix.foodsaverAPI.dto.SignInDTO;
import com.funix.foodsaverAPI.dto.SignUpDTO;
import com.funix.foodsaverAPI.dto.UserDTO;
import com.funix.foodsaverAPI.models.MyUser;
import com.funix.foodsaverAPI.models.Role;
import com.funix.foodsaverAPI.repositories.IUserRepository;
import com.funix.foodsaverAPI.utils.ValidationUtils;

import jakarta.servlet.http.HttpServletRequest;

import com.funix.foodsaverAPI.utils.ImageUtils;
import com.funix.foodsaverAPI.utils.ParseUtils;

@Service
public class UserServiceImpl implements IUserService {

	@Autowired
	private IUserRepository userRepository;

	@Autowired
	private ModelMapper modelMapper;

	@Autowired
	private JWTService jWTService;

	@Override
	public UserDTO convertToDto(MyUser user) {
		UserDTO userDTO = modelMapper.map(user, UserDTO.class);
//		if (user.getImageUrl() != null) {
//			userDTO.setImageUrl("http://localhost:8080/api/image/user/"
//				+ user.getImageUrl());
//		}
		return userDTO;
	}

	@Override
	public MyUser convertToEntity(UserDTO userDTO) {
		return modelMapper.map(userDTO, MyUser.class);
	}

	@Override
	public List<MyUser> getAllUsers() {
		return userRepository.findAll();
	}

	@Override
	public UserDTO updateUserInfo(HttpServletRequest request, UserDTO userDTO) {

		MyUser user = getUserByToken(request);
		// update Image
		if (userDTO.getImageFile() != null) {
			MultipartFile image = userDTO.getImageFile();
			try {
				user.setAvatar(
					Base64.getEncoder().encodeToString(
						ImageUtils.resizeImage(image.getBytes(), 500, 500)));
				user.setImageType(image.getContentType());
				String array[] = image.getContentType().split("/");
				String imageUrl = ParseUtils.parseImageUrl(image.getBytes());
				if (array.length > 1) {
					user.setImageUrl(
						imageUrl + "." + array[1]);
				} else {
					user.setImageUrl(
						imageUrl);
				}
			} catch (Exception e) {
				System.out.println("Upload Image Exception: " + e.getMessage());
			}
		}
		// update email
		if (!ValidationUtils.isNullOrEmpty(userDTO.getEmail())) {
			user.setEmail(userDTO.getEmail());
		}
		// update phone
		if (!ValidationUtils.isNullOrEmpty(userDTO.getPhone())) {
			user.setPhone(userDTO.getPhone());
		}
		// update address
		if (!ValidationUtils.isNullOrEmpty(userDTO.getAddress())) {
			user.setAddress(userDTO.getAddress());
		}
		this.userRepository.save(user);
		return convertToDto(getUserById(user.getId()));
	}

	@Override
	public MyUser getUserById(int id) {
		Optional<MyUser> optionalUser = userRepository.findById(id);
		MyUser user = null;
		if (optionalUser.isPresent()) {
			user = optionalUser.get();
		}
		return user;
	}

	@Override
	public MyUser getUserByName(String name) {
		Optional<MyUser> optionalUser = userRepository.findByName(name);
		MyUser user = null;
		if (optionalUser.isPresent()) {
			user = optionalUser.get();
		}
		return user;
	}

	@Override
	public MyUser getUserByImageUrl(String url) {
		Optional<MyUser> optionalUser = userRepository.findByImageUrl(url);
		MyUser user = null;
		if (optionalUser.isPresent()) {
			user = optionalUser.get();
			return user;
		} else {
			return null;
		}
	}

	@Override
	public MyUser getUserByToken(HttpServletRequest request) {
		String array[] = request.getHeader("Authorization").split(" ");
		String name = jWTService.extractUsername(array[1]);
		Optional<MyUser> optionalUser = userRepository.findByName(name);
		MyUser user = null;
		if (optionalUser.isPresent()) {
			user = optionalUser.get();
		}
		return user;
	}

	@Override
	public SignUpDTO existsByNameSignUp(SignUpDTO signUpDTO) {
		signUpDTO.setHasError(false);
		if (userRepository.existsByName(signUpDTO.getName())) {
			signUpDTO.setNameError("Username is existed.");
			signUpDTO.setHasError(true);
		}
		return signUpDTO;
	}

	@Override
	public SignUpDTO existsByEmailSignUp(SignUpDTO signUpDTO) {
		signUpDTO.setHasError(false);
		if (userRepository.existsByEmail(signUpDTO.getEmail())) {
			signUpDTO.setEmailError("Email is existed.");
			signUpDTO.setHasError(true);
		}
		return signUpDTO;
	}

	@Override
	public SignUpDTO existsByPhoneSignUp(SignUpDTO signUpDTO) {
		signUpDTO.setHasError(false);
		if (userRepository.existsByPhone(signUpDTO.getPhone())) {
			signUpDTO.setPhoneError("Phone is existed.");
			signUpDTO.setHasError(true);
		}
		return signUpDTO;
	}

	@Override
	public SignUpDTO checkInformationSignUpValid(SignUpDTO signUpDTO) {
		signUpDTO.setHasError(false);
		if (ValidationUtils.isNullOrEmpty(signUpDTO.getName())
			|| ValidationUtils.isNullOrEmpty(signUpDTO.getPassword())
			|| ValidationUtils.isNullOrEmpty(signUpDTO.getConfirmPassword())
			|| ValidationUtils.isNullOrEmpty(signUpDTO.getEmail())
			|| ValidationUtils.isNullOrEmpty(signUpDTO.getPhone())
			|| ValidationUtils.isNullOrEmpty(signUpDTO.getAddress())) {
			if (ValidationUtils.isNullOrEmpty(signUpDTO.getName())) {
				signUpDTO.setNameError("Username can't be empty.");
			}
			if (ValidationUtils.isNullOrEmpty(signUpDTO.getPassword())) {
				signUpDTO.setPasswordError("Password can't be empty.");
			}
			if (ValidationUtils.isNullOrEmpty(signUpDTO.getConfirmPassword())) {
				signUpDTO.setConfirmPasswordError(
					"Confirm Password can't be empty.");
			}
			if (ValidationUtils.isNullOrEmpty(signUpDTO.getEmail())) {
				signUpDTO.setEmailError("Email can't be empty.");
			}
			if (ValidationUtils.isNullOrEmpty(signUpDTO.getPhone())) {
				signUpDTO.setPhoneError("Phone can't be empty.");
			}
			if (ValidationUtils.isNullOrEmpty(signUpDTO.getAddress())) {
				signUpDTO.setAddressError("Address can't be empty.");
			}
			signUpDTO.setHasError(true);
			return signUpDTO;
		}
		if (!signUpDTO.getPassword()
			.equals(signUpDTO.getConfirmPassword())) {
			signUpDTO.setPasswordError(
				"Password and Confirm Password aren't matched.");
			signUpDTO.setConfirmPasswordError(
				"Password and Confirm Password aren't matched.");
			signUpDTO.setHasError(true);
			return signUpDTO;
		}
		return signUpDTO;
	}

	@Override
	public void signUp(SignUpDTO signUpDTO) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		signUpDTO.setPassword(passwordEncoder.encode(signUpDTO.getPassword()));
		MyUser user = modelMapper.map(signUpDTO, MyUser.class);
		user.setRole(new Role());
		user.getRole().setId(3);
		this.userRepository.save(user);
	}

	@Override
	public SignInDTO checkInformationSignInValid(SignInDTO signInDTO) {
		signInDTO.setHasError(false);
		if (ValidationUtils.isNullOrEmpty(signInDTO.getName())
			|| ValidationUtils.isNullOrEmpty(signInDTO.getPassword())) {
			if (ValidationUtils.isNullOrEmpty(signInDTO.getName())) {
				signInDTO.setNameError("Username can't be empty.");
			}
			if (ValidationUtils.isNullOrEmpty(signInDTO.getPassword())) {
				signInDTO.setPasswordError("Password can't be empty.");
			}
			signInDTO.setHasError(true);
		}
		return signInDTO;
	}

	@Override
	public SignInDTO existsByNameSignIn(SignInDTO signInDTO) {
		signInDTO.setHasError(false);
		if (!userRepository.existsByName(signInDTO.getName())) {
			signInDTO.setNameError("Username or Password isn't correct.");
			signInDTO.setPasswordError("Username or Password isn't correct.");
			signInDTO.setHasError(true);
		}
		return signInDTO;
	}

	@Override
	public SignInDTO validatePasswordSignIn(SignInDTO signInDTO) {
		signInDTO.setHasError(false);

		Optional<MyUser> optionalUser = userRepository
			.findByName(signInDTO.getName());
		MyUser user = null;
		if (optionalUser.isPresent()) {
			user = optionalUser.get();
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			if (!encoder.matches(signInDTO.getPassword(), user.getPassword())) {
				signInDTO.setNameError("Username or Password isn't correct.");
				signInDTO
					.setPasswordError("Username or Password isn't correct.");
				signInDTO.setHasError(true);
				return signInDTO;
			}
		}
		return signInDTO;
	}
}
