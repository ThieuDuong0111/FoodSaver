package com.funix.foodsaveradmin.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping({ "/login" })
public class LoginController {

	@GetMapping({ "", "/" })
	public String viewLoginPage(Model model) {
		return "login_page";
	}

	/*
	 * @PostMapping("/login") public String signIn(BindingResult result) {
	 * 
	 * if (result.hasErrors()) { return "login_page"; }
	 * 
	 * return "index"; }
	 */
}
