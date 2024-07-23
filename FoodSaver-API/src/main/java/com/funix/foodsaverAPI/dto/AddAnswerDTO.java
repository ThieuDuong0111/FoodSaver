package com.funix.foodsaverAPI.dto;

public class AddAnswerDTO {

	private int userId;

	private int feedBackId;

	private String answer;

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getFeedBackId() {
		return feedBackId;
	}

	public void setFeedBackId(int feedBackId) {
		this.feedBackId = feedBackId;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

}
