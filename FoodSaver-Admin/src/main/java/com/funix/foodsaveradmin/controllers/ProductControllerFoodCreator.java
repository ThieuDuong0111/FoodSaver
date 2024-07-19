package com.funix.foodsaveradmin.controllers;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.*;

import com.funix.foodsaveradmin.dto.ProductDTO;
import com.funix.foodsaveradmin.models.Product;
import com.funix.foodsaveradmin.services.CategoryServiceImpl;
import com.funix.foodsaveradmin.services.ProductServiceImpl;
import com.funix.foodsaveradmin.services.UnitServiceImpl;
import com.funix.foodsaveradmin.services.UserServiceImpl;

import jakarta.validation.Valid;

@Controller
@RequestMapping({ "/food_creator/products" })
public class ProductControllerFoodCreator {
	private static String redirectProduct = "redirect:/food_creator/products/page/1?sortField=id&sortDir=desc";

	@Autowired
	private ProductServiceImpl productServiceImpl;

	@Autowired
	private CategoryServiceImpl categoryServiceImpl;

	@Autowired
	private UnitServiceImpl unitServiceImpl;

	@Autowired
	private UserServiceImpl userServiceImpl;

	@GetMapping({ "", "/" })
	public String viewProductPage(Model model) {
		return redirectProduct;
	}

	@GetMapping("/add")
	public String showNewProductForm(
		Model model) {
		ProductDTO productDTO = new ProductDTO();
		Date currentDateTime = new Date();
		productDTO.setExpiredDate(currentDateTime);
		productDTO.setCategories(categoryServiceImpl.getAllCategories());
		productDTO.setUnits(unitServiceImpl.getAllUnits());
		model.addAttribute("productDTO", productDTO);
		model.addAttribute("creator_id",
			userServiceImpl.getLoggedInUserInfo().getId());
		return "create_product";
	}

	@PostMapping("/add")
	public String addProduct(@Valid @ModelAttribute ProductDTO productDTO,
		BindingResult result,
		Model model) {

		if (result.hasErrors()) {
			productDTO.setCategories(categoryServiceImpl.getAllCategories());
			productDTO.setUnits(unitServiceImpl.getAllUnits());
			model.addAttribute("productDTO", productDTO);
			model.addAttribute("creator_id",
				userServiceImpl.getLoggedInUserInfo().getId());
			return "create_product";
		}

		try {
			productServiceImpl.saveProduct(productDTO);
		} catch (Exception e) {
			return redirectProduct;
		}

		return redirectProduct;
	}

	@GetMapping("/update/{id}")
	public String showFormForUpdate(@PathVariable(value = "id") int id,
		Model model) {
		ProductDTO productDTO = productServiceImpl.getProductById(id);
		productDTO.setUnits(unitServiceImpl.getAllUnits());
		productDTO.setCategories(categoryServiceImpl.getAllCategories());
		model.addAttribute("productDTO", productDTO);
		model.addAttribute("creator_id",
			userServiceImpl.getLoggedInUserInfo().getId());
		return "update_product";
	}

	@PostMapping("/update")
	public String updateProduct(@Valid @ModelAttribute ProductDTO productDTO,
		BindingResult result,
		Model model) {

		if (result.hasErrors()) {
			productDTO.setCreator(
				userServiceImpl
					.convertToEntity(userServiceImpl.getUserById(
						userServiceImpl.getLoggedInUserInfo().getId())));
			productDTO.setUnits(unitServiceImpl.getAllUnits());
			productDTO.setCategories(categoryServiceImpl.getAllCategories());
			model.addAttribute("productDTO", productDTO);
			model.addAttribute("creator_id",
				userServiceImpl.getLoggedInUserInfo().getId());
			return "update_product";
		}
		try {
			productServiceImpl.saveProduct(productDTO);
		} catch (Exception e) {
			return redirectProduct;
		}

		return redirectProduct;
	}

	@GetMapping("/delete/{id}")
	public String deleteProduct(@PathVariable(value = "id") int id) {
		try {
			productServiceImpl.deleteProductById(id);
		} catch (Exception e) {
			return redirectProduct;
		}

		return redirectProduct;
	}

	@GetMapping("/page/{pageNo}")
	public String findPaginated(@PathVariable(value = "pageNo") int pageNo,
		@RequestParam(value = "sortField", required = true) String sortField,
		@RequestParam(value = "sortDir", required = true) String sortDir,

		Model model) {
		int pageSize = 12;

		Page<Product> page = productServiceImpl.findPaginated(pageNo,
			pageSize,
			sortField, sortDir, userServiceImpl.getLoggedInUserInfo().getId());
		List<Product> listproducts = page.getContent();

		model.addAttribute("currentPage", pageNo);
		model.addAttribute("totalPages", page.getTotalPages());
		model.addAttribute("totalItems", page.getTotalElements());

		model.addAttribute("sortField", sortField);
		model.addAttribute("sortDir", sortDir);
		model.addAttribute("reverseSortDir",
			sortDir.equals("asc") ? "desc" : "asc");
		model.addAttribute("listproducts", listproducts);

		return "list_products_food_creator";
	}
}
