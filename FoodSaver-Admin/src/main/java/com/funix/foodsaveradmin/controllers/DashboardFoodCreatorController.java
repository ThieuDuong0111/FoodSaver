package com.funix.foodsaveradmin.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping({ "/food_creator/dashboard" })
public class DashboardFoodCreatorController {
	@GetMapping({ "", "/" })
	public String viewProductPage(Model model) {
		return "dashboard_food_creator";
	}
}
