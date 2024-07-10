package com.funix.foodsaveradmin.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.*;

import com.funix.foodsaveradmin.models.Product;
import com.funix.foodsaveradmin.services.ProductServiceImpl;

@Controller
@RequestMapping({ "/admin/products" })
public class ProductControllerAdmin {
	private static String redirectProduct = "redirect:/admin/products/page/1?sortField=id&sortDir=desc";

	@Autowired
	private ProductServiceImpl productServiceImpl;

	@GetMapping({ "", "/" })
	public String viewProductPage(Model model) {
		return redirectProduct;
	}

	@GetMapping("/page/{pageNo}")
	public String findPaginated(@PathVariable(value = "pageNo") int pageNo,
		@RequestParam(value = "sortField", required = true) String sortField,
		@RequestParam(value = "sortDir", required = true) String sortDir,
		Model model) {
		int pageSize = 12;

		Page<Product> page = productServiceImpl.findPaginatedAll(pageNo,
			pageSize,
			sortField, sortDir);
		List<Product> listproducts = page.getContent();

		model.addAttribute("currentPage", pageNo);
		model.addAttribute("totalPages", page.getTotalPages());
		model.addAttribute("totalItems", page.getTotalElements());

		model.addAttribute("sortField", sortField);
		model.addAttribute("sortDir", sortDir);
		model.addAttribute("reverseSortDir",
			sortDir.equals("asc") ? "desc" : "asc");
		model.addAttribute("listproducts", listproducts);

		return "list_products_admin";
	}
}
