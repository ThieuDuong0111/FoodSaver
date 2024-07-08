package com.funix.foodsaveradmin.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.*;

import com.funix.foodsaveradmin.dto.UserDTO;
import com.funix.foodsaveradmin.models.MyUser;
import com.funix.foodsaveradmin.services.UserServiceImpl;

import jakarta.validation.Valid;

@Controller
@RequestMapping({ "/admin/users" })
public class UserController {
	private static String redirectUser = "redirect:/admin/users/page/1?sortField=id&sortDir=desc&role_id=";

	@Autowired
	private UserServiceImpl userServiceImpl;

	@GetMapping({ "", "/" })
	public String viewUserPage(Model model) {
		return redirectUser;
	}

	@GetMapping("/add")
	public String showNewUserForm(
		@RequestParam(value = "role_id", required = true) int role_id,
		Model model) {
		UserDTO userDTO = new UserDTO();
		model.addAttribute("userDTO", userDTO);
		model.addAttribute("role_id", role_id);
		return "create_user";
	}

	@PostMapping("/add")
	public String addUser(@Valid @ModelAttribute UserDTO userDTO,
		BindingResult result) {

		if (result.hasErrors()) {
			return "create_user";
		}

		try {
			userServiceImpl.saveUser(userDTO, true);
		} catch (Exception e) {
			return redirectUser
				+ userDTO.getRole().getId();
		}

		return redirectUser
			+ userDTO.getRole().getId();
	}

	@GetMapping("/update/{id}")
	public String showFormForUpdate(@PathVariable(value = "id") int id,
		Model model) {
		UserDTO userDTO = userServiceImpl.getUserById(id);
		model.addAttribute("userDTO", userDTO);
		model.addAttribute("role_id", userDTO.getRole().getId());
		return "update_user";
	}

	@PostMapping("/update")
	public String updateUser(@Valid @ModelAttribute UserDTO userDTO,
		BindingResult result) {

		if (result.hasErrors()) {
			return "update_user";
		}
		try {
			userServiceImpl.saveUser(userDTO, false);
		} catch (Exception e) {
			return redirectUser
				+ userDTO.getRole().getId();
		}

		return redirectUser
			+ userDTO.getRole().getId();
	}

	@GetMapping("/delete/{id}")
	public String deleteCourse(@PathVariable(value = "id") int id,
		@RequestParam(value = "role_id", required = true) int role_id) {
		try {
			this.userServiceImpl.deleteUserById(id);
		} catch (Exception e) {
			return redirectUser
				+ role_id;
		}
		return redirectUser
			+ role_id;
	}

	@GetMapping("/page/{pageNo}")
	public String findPaginated(@PathVariable(value = "pageNo") int pageNo,
		@RequestParam(value = "sortField", required = true) String sortField,
		@RequestParam(value = "sortDir", required = true) String sortDir,
		@RequestParam(value = "role_id", required = true) int role_id,
		Model model) {
		int pageSize = 12;
		Page<MyUser> page = userServiceImpl.findPaginated(pageNo, pageSize,
			sortField, sortDir, role_id);
		List<MyUser> listUsers = page.getContent();

		model.addAttribute("currentPage", pageNo);
		model.addAttribute("totalPages", page.getTotalPages());
		model.addAttribute("totalItems", page.getTotalElements());

		model.addAttribute("sortField", sortField);
		model.addAttribute("sortDir", sortDir);
		model.addAttribute("reverseSortDir",
			sortDir.equals("asc") ? "desc" : "asc");
		model.addAttribute("listUsers", listUsers);
		model.addAttribute("role_id", role_id);
		return "list_users";
	}
}
