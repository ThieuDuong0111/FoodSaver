package com.funix.foodsaveradmin.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.*;

import com.funix.foodsaveradmin.dto.CategoryDTO;
import com.funix.foodsaveradmin.models.Category;
import com.funix.foodsaveradmin.services.CategoryServiceImpl;

import jakarta.validation.Valid;

@Controller
@RequestMapping({ "/admin/categories" })
public class CategoryController {
	private static String redirectCategory = "redirect:/admin/categories/page/1?sortField=id&sortDir=desc";

	@Autowired
	private CategoryServiceImpl categoryServiceImpl;

	@GetMapping({ "", "/" })
	public String viewProductPage(Model model) {
		return redirectCategory;
	}

	@GetMapping("/add")
	public String showNewProductForm(
		Model model) {
		CategoryDTO categoryDTO = new CategoryDTO();
		model.addAttribute("categoryDTO", categoryDTO);
		return "create_category";
	}

	@PostMapping("/add")
	public String addCategory(@Valid @ModelAttribute CategoryDTO categoryDTO,
		BindingResult result) {

		if (result.hasErrors()) {
			return "create_category";
		}

		try {
			categoryServiceImpl.saveCategory(categoryDTO);
		} catch (Exception e) {
			return redirectCategory;
		}

		return redirectCategory;
	}

	@GetMapping("/update/{id}")
	public String showFormForUpdate(@PathVariable(value = "id") int id,
		Model model) {
		CategoryDTO categoryDTO = categoryServiceImpl
			.convertToDto(categoryServiceImpl.getCategoryById(id));
		model.addAttribute("categoryDTO", categoryDTO);
		return "update_category";
	}

	@PostMapping("/update")
	public String updateCategory(@Valid @ModelAttribute CategoryDTO categoryDTO,
		BindingResult result) {

		if (result.hasErrors()) {
			return "update_category";
		}
		try {
			categoryServiceImpl.saveCategory(categoryDTO);
		} catch (Exception e) {
			return redirectCategory;
		}

		return redirectCategory;
	}

	@GetMapping("/delete/{id}")
	public String deleteCourse(@PathVariable(value = "id") int id) {
		try {
			categoryServiceImpl.deleteCategoryById(id);
		} catch (Exception e) {
			return redirectCategory;
		}

		return redirectCategory;
	}

	@GetMapping("/page/{pageNo}")
	public String findPaginated(@PathVariable(value = "pageNo") int pageNo,
		@RequestParam(value = "sortField", required = true) String sortField,
		@RequestParam(value = "sortDir", required = true) String sortDir,

		Model model) {
		int pageSize = 12;

		Page<Category> page = categoryServiceImpl.findPaginated(pageNo,
			pageSize,
			sortField, sortDir);
		List<Category> listCategories = page.getContent();

		model.addAttribute("currentPage", pageNo);
		model.addAttribute("totalPages", page.getTotalPages());
		model.addAttribute("totalItems", page.getTotalElements());

		model.addAttribute("sortField", sortField);
		model.addAttribute("sortDir", sortDir);
		model.addAttribute("reverseSortDir",
			sortDir.equals("asc") ? "desc" : "asc");
		model.addAttribute("listCategories", listCategories);

		return "list_categories";
	}
}
