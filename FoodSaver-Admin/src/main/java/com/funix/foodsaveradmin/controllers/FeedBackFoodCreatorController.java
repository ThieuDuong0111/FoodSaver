package com.funix.foodsaveradmin.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.funix.foodsaveradmin.dto.AnswerDTO;
import com.funix.foodsaveradmin.models.Answer;
import com.funix.foodsaveradmin.models.FeedBack;
import com.funix.foodsaveradmin.services.AnswerServiceImpl;
import com.funix.foodsaveradmin.services.FeedBackServiceImpl;
import com.funix.foodsaveradmin.services.UserServiceImpl;

import jakarta.validation.Valid;

@Controller
@RequestMapping({ "/food_creator/feedbacks" })
public class FeedBackFoodCreatorController {
	private static String redirectFeedback = "redirect:/food_creator/feedbacks/page/1?sortField=id&sortDir=desc";

	@Autowired
	private FeedBackServiceImpl feedBackServiceImpl;

	@Autowired
	private AnswerServiceImpl answerServiceImpl;

	@Autowired
	private UserServiceImpl userServiceImpl;

	@GetMapping({ "", "/" })
	public String viewOrderPage(Model model) {
		return redirectFeedback;
	}

	@GetMapping("/detail/{id}/page/{pageNo}")
	public String showDetail(@PathVariable(value = "id") int id,
		@PathVariable(value = "pageNo") int pageNo,
		@RequestParam(value = "sortField", required = true) String sortField,
		@RequestParam(value = "sortDir", required = true) String sortDir,
		Model model) {
		int pageSize = 12;

		Page<Answer> page = answerServiceImpl.findPaginated(
			pageNo,
			pageSize,
			sortField, sortDir, id);
		List<Answer> listAnswers = page.getContent();
		AnswerDTO answerDTO = new AnswerDTO();
		model.addAttribute("currentPage", pageNo);
		model.addAttribute("totalPages", page.getTotalPages());
		model.addAttribute("totalItems", page.getTotalElements());
		model.addAttribute("sortField", sortField);
		model.addAttribute("sortDir", sortDir);
		model.addAttribute("reverseSortDir",
			sortDir.equals("asc") ? "desc" : "asc");
		model.addAttribute("listAnswers", listAnswers);
		model.addAttribute("answerDTO", answerDTO);
		model.addAttribute("feedback_id",
			id);
		model.addAttribute("user_id",
			userServiceImpl.getLoggedInUserInfo().getId());
		return "feedback_detail_food_creator";
	}

	@PostMapping("/add_answer")
	public String addProduct(@Valid @ModelAttribute AnswerDTO answerDTO,
		BindingResult result,
		Model model) {

		if (result.hasErrors()) {
			model.addAttribute("answerDTO", answerDTO);
			model.addAttribute("user_id",
				userServiceImpl.getLoggedInUserInfo().getId());
			return redirectFeedback;
		}

		try {
			answerServiceImpl.saveAnswer(answerDTO);
		} catch (Exception e) {
			return redirectFeedback;
		}

		return redirectFeedback;
	}

	@GetMapping("/page/{pageNo}")
	public String findPaginated(@PathVariable(value = "pageNo") int pageNo,
		@RequestParam(value = "sortField", required = true) String sortField,
		@RequestParam(value = "sortDir", required = true) String sortDir,

		Model model) {
		int pageSize = 12;

		Page<FeedBack> page = feedBackServiceImpl.findAllByCreatorIdPagination(
			pageNo,
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
		return "list_feedbacks_food_creator";
	}
}
