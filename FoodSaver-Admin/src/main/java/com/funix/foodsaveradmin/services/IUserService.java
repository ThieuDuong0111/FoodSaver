package com.funix.foodsaveradmin.services;

import java.util.List;

import org.springframework.data.domain.Page;

import com.funix.foodsaveradmin.dto.UserDTO;
import com.funix.foodsaveradmin.models.CustomUserDetails;
import com.funix.foodsaveradmin.models.MyUser;

public interface IUserService {

	UserDTO convertToDto(MyUser user);

	MyUser convertToEntity(UserDTO userDTO);

	List<MyUser> getAllUsers();

	void saveUser(UserDTO userDTO, Boolean isCreate);

	UserDTO getUserById(int id);

	void deleteUserById(int id);

	Page<MyUser> findPaginated(int pageNum, int pageSize,
		String sortField,
		String sortDirection, int role_id);

	CustomUserDetails getLoggedInUserInfo();
}
