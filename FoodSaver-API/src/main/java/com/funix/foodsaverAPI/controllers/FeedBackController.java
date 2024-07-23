package com.funix.foodsaverAPI.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.funix.foodsaverAPI.dto.AddAnswerDTO;
import com.funix.foodsaverAPI.dto.AddFeedBackDTO;
import com.funix.foodsaverAPI.services.AnswerServiceImpl;
import com.funix.foodsaverAPI.services.FeedBackServiceImpl;

@RestController
@RequestMapping("/api/feedback")
public class FeedBackController {
	
	@Autowired
	private FeedBackServiceImpl feedBackServiceImpl;
	
	@Autowired
	private AnswerServiceImpl answerServiceImpl;
	

	@PostMapping("/add-feedback")
	public ResponseEntity<?> addFeedBack(
		@RequestBody AddFeedBackDTO addFeedBackDTO) {
		feedBackServiceImpl.addFeedBack(addFeedBackDTO);
		return ResponseEntity.status(HttpStatus.OK)
			.body(addFeedBackDTO);
	}

	@GetMapping("/get-feedbacks/{id}")
	public ResponseEntity<?> getFeedBacksByProductId(
		@PathVariable int id) {
		return ResponseEntity.status(HttpStatus.OK)
			.body(feedBackServiceImpl.getFeedBacksByProductId(id));
	}
	
	@PostMapping("/add-answer")
	public ResponseEntity<?> addAnswer(
		@RequestBody AddAnswerDTO addAnswerDTO) {
		answerServiceImpl.addAnswer(addAnswerDTO);
		return ResponseEntity.status(HttpStatus.OK)
			.body(addAnswerDTO);
	}
}
