package com.funix.foodsaverAPI.dto;

public class SuccessMessageResponse {

	private String successMessage;

	public SuccessMessageResponse(String errorMessage) {
		super();
		this.successMessage = errorMessage;
	}

	public String getSuccessMessage() {
		return successMessage;
	}

	public void setSuccessMessage(String errorMessage) {
		this.successMessage = errorMessage;
	}
}
