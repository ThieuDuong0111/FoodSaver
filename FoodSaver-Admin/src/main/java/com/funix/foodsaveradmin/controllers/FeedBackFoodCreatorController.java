package com.funix.foodsaveradmin.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.funix.foodsaveradmin.models.FeedBack;
import com.funix.foodsaveradmin.services.FeedBackServiceImpl;
import com.funix.foodsaveradmin.services.UserServiceImpl;

@Controller
@RequestMapping({ "/food_creator/feedbacks" })
public class FeedBackFoodCreatorController {
	private static String redirectOrder = "redirect:/food_creator/feedbacks/page/1?sortField=id&sortDir=desc";

	@Autowired
	private FeedBackServiceImpl feedBackServiceImpl;

	@Autowired
	private UserServiceImpl userServiceImpl;

	@GetMapping({ "", "/" })
	public String viewOrderPage(Model model) {
		return redirectOrder;
	}

//	@GetMapping("/page/{pageNo}")
//	public String findPaginated(@PathVariable(value = "pageNo") int pageNo,
//		@RequestParam(value = "sortField", required = true) String sortField,
//		@RequestParam(value = "sortDir", required = true) String sortDir,
//
//		Model model) {
//		int pageSize = 12;
//
//		List<FeedBack> listFeedBacks = feedBackServiceImpl.findPaginated(pageNo,
//			pageSize,
//			sortField, sortDir, userServiceImpl.getLoggedInUserInfo().getId());
////		List<FeedBack> listFeedBacks = page.getContent();
//
//		/*
//		 * model.addAttribute("currentPage", pageNo);
//		 * model.addAttribute("totalPages", page.getTotalPages());
//		 * model.addAttribute("totalItems", page.getTotalElements());
//		 * 
//		 * model.addAttribute("sortField", sortField);
//		 * model.addAttribute("sortDir", sortDir);
//		 * model.addAttribute("reverseSortDir", sortDir.equals("asc") ? "desc" :
//		 * "asc"); model.addAttribute("listFeedBacks", listFeedBacks);
//		 */
//		model.addAttribute("listFeedBacks", listFeedBacks);
//		return "list_feedbacks_food_creator";
//	}

	@GetMapping("/page/{pageNo}")
	public String findPaginated(@PathVariable(value = "pageNo") int pageNo,
		@RequestParam(value = "sortField", required = true) String sortField,
		@RequestParam(value = "sortDir", required = true) String sortDir,

		Model model) {
		int pageSize = 12;

		Page<FeedBack> page = feedBackServiceImpl.findAllByCreatorIdPagination(pageNo,
			pageSize,
			sortField, sortDir, userServiceImpl.getLoggedInUserInfo().getId());
		List<FeedBack> listFeedBacks = page.getContent();

		model.addAttribute("currentPage", pageNo);
		model.addAttribute("totalPages", page.getTotalPages());
		model.addAttribute("totalItems", page.getTotalElements());
		model.addAttribute("sortField", sortField);
		model.addAttribute("sortDir", sortDir);
		model.addAttribute("reverseSortDir",
			sortDir.equals("asc") ? "desc" : "asc");
		model.addAttribute("listFeedBacks", listFeedBacks);

		model.addAttribute("listFeedBacks", listFeedBacks);
		return "list_feedbacks_food_creator";
	}
}
