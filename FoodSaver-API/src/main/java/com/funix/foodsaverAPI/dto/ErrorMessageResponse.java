package com.funix.foodsaverAPI.dto;

public class ErrorMessageResponse {

	private String errorMessage;

	public ErrorMessageResponse(String errorMessage) {
		super();
		this.errorMessage = errorMessage;
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
}
