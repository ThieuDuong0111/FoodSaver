package com.funix.foodsaverAPI.dto;

import java.util.Date;

public class AnswerDTO {
	private int id;

	private UserDTO userAnswer;

	private String answer;

	private Boolean isCreator;

	private Date publishedDate;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public UserDTO getUserAnswer() {
		return userAnswer;
	}

	public void setUserAnswer(UserDTO userAnswer) {
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
