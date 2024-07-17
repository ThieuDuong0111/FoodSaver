package com.funix.foodsaveradmin.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.*;

import com.funix.foodsaveradmin.dto.BannerDTO;
import com.funix.foodsaveradmin.models.Banner;
import com.funix.foodsaveradmin.services.IBannerService;

import jakarta.validation.Valid;

@Controller
@RequestMapping({ "/admin/banners" })
public class BannerController {
	private static String redirectBanner = "redirect:/admin/banners/page/1?sortField=id&sortDir=desc";

	@Autowired
	private IBannerService bannerServiceImpl;

	@GetMapping({ "", "/" })
	public String viewProductPage(Model model) {
		return redirectBanner;
	}

	@GetMapping("/add")
	public String showNewProductForm(
		Model model) {
		BannerDTO BannerDTO = new BannerDTO();
		model.addAttribute("bannerDTO", BannerDTO);
		return "create_banner";
	}

	@PostMapping("/add")
	public String addCategory(@Valid @ModelAttribute BannerDTO BannerDTO,
		BindingResult result) {

		if (result.hasErrors()) {
			return "create_banner";
		}

		try {
			bannerServiceImpl.saveBanner(BannerDTO);
		} catch (Exception e) {
			return redirectBanner;
		}

		return redirectBanner;
	}

	@GetMapping("/update/{id}")
	public String showFormForUpdate(@PathVariable(value = "id") int id,
		Model model) {
		BannerDTO BannerDTO = bannerServiceImpl.getBannerById(id);
		model.addAttribute("bannerDTO", BannerDTO);
		return "update_banner";
	}

	@PostMapping("/update")
	public String updateCategory(@Valid @ModelAttribute BannerDTO BannerDTO,
		BindingResult result) {

		if (result.hasErrors()) {
			return "update_banner";
		}
		try {
			bannerServiceImpl.saveBanner(BannerDTO);
		} catch (Exception e) {
			return redirectBanner;
		}

		return redirectBanner;
	}

	@GetMapping("/delete/{id}")
	public String deleteCourse(@PathVariable(value = "id") int id) {
		try {
			bannerServiceImpl.deleteBannerById(id);
		} catch (Exception e) {
			return redirectBanner;
		}

		return redirectBanner;
	}

	@GetMapping("/page/{pageNo}")
	public String findPaginated(@PathVariable(value = "pageNo") int pageNo,
		@RequestParam(value = "sortField", required = true) String sortField,
		@RequestParam(value = "sortDir", required = true) String sortDir,

		Model model) {
		int pageSize = 12;

		Page<Banner> page = bannerServiceImpl.findPaginated(pageNo,
			pageSize,
			sortField, sortDir);
		List<Banner> listbanners = page.getContent();

		model.addAttribute("currentPage", pageNo);
		model.addAttribute("totalPages", page.getTotalPages());
		model.addAttribute("totalItems", page.getTotalElements());

		model.addAttribute("sortField", sortField);
		model.addAttribute("sortDir", sortDir);
		model.addAttribute("reverseSortDir",
			sortDir.equals("asc") ? "desc" : "asc");
		model.addAttribute("listbanners", listbanners);

		return "list_banners";
	}
}
