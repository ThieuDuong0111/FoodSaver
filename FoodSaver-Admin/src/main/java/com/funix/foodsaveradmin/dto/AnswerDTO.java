package com.funix.foodsaveradmin.dto;

import java.util.Date;

import com.funix.foodsaveradmin.models.FeedBack;
import com.funix.foodsaveradmin.models.MyUser;

public class AnswerDTO {

	private int id;

	private FeedBack feedback;

	private MyUser userAnswer;

	private String answer;

	private Boolean isCreator;

	private Date publishedDate;

	public AnswerDTO() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public FeedBack getFeedback() {
		return feedback;
	}

	public void setFeedback(FeedBack feedback) {
		this.feedback = feedback;
	}

	public MyUser getUserAnswer() {
		return userAnswer;
	}

	public void setUserAnswer(MyUser userAnswer) {
		this.userAnswer = userAnswer;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public Boolean getIsCreator() {
		return isCreator;
	}

	public void setIsCreator(Boolean isCreator) {
		this.isCreator = isCreator;
	}

	public Date getPublishedDate() {
		return publishedDate;
	}

	public void setPublishedDate(Date publishedDate) {
		this.publishedDate = publishedDate;
	}

}
