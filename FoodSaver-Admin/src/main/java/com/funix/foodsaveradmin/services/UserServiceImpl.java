package com.funix.foodsaveradmin.services;

import java.util.Base64;
import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.funix.foodsaveradmin.dto.UserDTO;
import com.funix.foodsaveradmin.models.CustomUserDetails;
import com.funix.foodsaveradmin.models.MyUser;
import com.funix.foodsaveradmin.repositories.IUserRepository;
import com.funix.foodsaveradmin.utils.ImageUtils;
import com.funix.foodsaveradmin.utils.ParseUtils;

@Service
public class UserServiceImpl implements IUserService {

	@Autowired
	private IUserRepository userRepository;

	@Autowired
	private ModelMapper modelMapper;

	@Override
	public UserDTO convertToDto(MyUser user) {
		return modelMapper.map(user, UserDTO.class);
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
	public void saveUser(UserDTO userDTO, Boolean isCreate) {
		// save image file
		if (userDTO.getImageFile() != null) {
			MultipartFile image = userDTO.getImageFile();
			try {
				userDTO.setAvatar(
					Base64.getEncoder().encodeToString(
						ImageUtils.resizeImage(image.getBytes(), 500, 500)));
				userDTO.setImageType(image.getContentType());
				String array[] = image.getContentType().split("/");
				String imageUrl = ParseUtils.parseImageUrl(image.getBytes());
				if (array.length > 1) {
					userDTO.setImageUrl(
						imageUrl + "." + array[1]);
				} else {
					userDTO.setImageUrl(
						imageUrl);
				}
			} catch (Exception e) {
				System.out.println("Upload Image Exception: " + e.getMessage());
			}
		}
		if (userDTO.getImageStoreFile() != null) {
			MultipartFile image = userDTO.getImageStoreFile();
			try {
				userDTO.setStoreImage(
					Base64.getEncoder().encodeToString(
						ImageUtils.resizeImage(image.getBytes(), 500, 1000)));
				userDTO.setStoreImageType(image.getContentType());
				String array[] = image.getContentType().split("/");
				String imageUrl = ParseUtils.parseImageUrl(image.getBytes());
				if (array.length > 1) {
					userDTO.setStoreImageUrl(
						imageUrl + "." + array[1]);
				} else {
					userDTO.setStoreImageUrl(
						imageUrl);
				}
			} catch (Exception e) {
				System.out.println("Upload Image Exception: " + e.getMessage());
			}
		}
		if (isCreate) {
			BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
			userDTO.setPassword(passwordEncoder.encode(userDTO.getPassword()));
		}

		this.userRepository.save(convertToEntity(userDTO));
	}

	@Override
	public UserDTO getUserById(int id) {
		Optional<MyUser> optionalUser = userRepository.findById(id);
		MyUser user = null;
		if (optionalUser.isPresent()) {
			user = optionalUser.get();
		} else {
			throw new RuntimeException("User not found for id : " + id);
		}
		return convertToDto(user);
	}

	@Override
	public void deleteUserById(int id) {
		this.userRepository.deleteById(id);
	}

	@Override
	public Page<MyUser> findPaginated(int pageNum, int pageSize,
		String sortField,
		String sortDirection, int role_id) {
		Sort sort = sortDirection.equalsIgnoreCase(Sort.Direction.ASC.name())
			? Sort.by(sortField).ascending()
			: Sort.by(sortField).descending();

		Pageable pageable = PageRequest.of(pageNum - 1, pageSize, sort);
		return this.userRepository.findAllByRoleId(role_id, pageable);
	}

	@Override
	public CustomUserDetails getLoggedInUserInfo() {
		Authentication authentication = SecurityContextHolder.getContext()
			.getAuthentication();
		if (authentication != null && authentication.isAuthenticated()) {
			Object principal = authentication.getPrincipal();
			if (principal instanceof UserDetails) {
				return ((CustomUserDetails) principal);
			}
		}
		return null;
	}
}
