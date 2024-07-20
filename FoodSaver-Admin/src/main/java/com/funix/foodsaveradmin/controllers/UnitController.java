package com.funix.foodsaveradmin.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.*;

import com.funix.foodsaveradmin.dto.UnitDTO;
import com.funix.foodsaveradmin.models.Unit;
import com.funix.foodsaveradmin.services.UnitServiceImpl;

import jakarta.validation.Valid;

@Controller
@RequestMapping({ "/admin/units" })
public class UnitController {
	private static String redirectUnit = "redirect:/admin/units/page/1?sortField=id&sortDir=desc";

	@Autowired
	private UnitServiceImpl unitServiceImpl;

	@GetMapping({ "", "/" })
	public String viewProductPage(Model model) {
		return redirectUnit;
	}

	@GetMapping("/add")
	public String showNewProductForm(
		Model model) {
		UnitDTO unitDTO = new UnitDTO();
		model.addAttribute("unitDTO", unitDTO);
		return "create_unit";
	}

	@PostMapping("/add")
	public String addUnit(@Valid @ModelAttribute UnitDTO unitDTO,
		BindingResult result) {

		if (result.hasErrors()) {
			return "create_unit";
		}

		try {
			unitServiceImpl.saveUnit(unitDTO);
		} catch (Exception e) {
			return redirectUnit;
		}

		return redirectUnit;
	}

	@GetMapping("/update/{id}")
	public String showFormForUpdate(@PathVariable(value = "id") int id,
		Model model) {
		UnitDTO unitDTO = unitServiceImpl
			.convertToDto(unitServiceImpl.getUnitById(id));
		model.addAttribute("unitDTO", unitDTO);
		return "update_unit";
	}

	@PostMapping("/update")
	public String updateUnit(@Valid @ModelAttribute UnitDTO UnitDTO,
		BindingResult result) {

		if (result.hasErrors()) {
			return "update_unit";
		}
		try {
			unitServiceImpl.saveUnit(UnitDTO);
		} catch (Exception e) {
			return redirectUnit;
		}

		return redirectUnit;
	}

	@GetMapping("/delete/{id}")
	public String deleteCourse(@PathVariable(value = "id") int id) {
		try {
			unitServiceImpl.deleteUnitById(id);
		} catch (Exception e) {
			return redirectUnit;
		}

		return redirectUnit;
	}

	@GetMapping("/page/{pageNo}")
	public String findPaginated(@PathVariable(value = "pageNo") int pageNo,
		@RequestParam(value = "sortField", required = true) String sortField,
		@RequestParam(value = "sortDir", required = true) String sortDir,

		Model model) {
		int pageSize = 12;

		Page<Unit> page = unitServiceImpl.findPaginated(pageNo,
			pageSize,
			sortField, sortDir);
		List<Unit> listunits = page.getContent();

		model.addAttribute("currentPage", pageNo);
		model.addAttribute("totalPages", page.getTotalPages());
		model.addAttribute("totalItems", page.getTotalElements());

		model.addAttribute("sortField", sortField);
		model.addAttribute("sortDir", sortDir);
		model.addAttribute("reverseSortDir",
			sortDir.equals("asc") ? "desc" : "asc");
		model.addAttribute("listunits", listunits);

		return "list_units";
	}
}
