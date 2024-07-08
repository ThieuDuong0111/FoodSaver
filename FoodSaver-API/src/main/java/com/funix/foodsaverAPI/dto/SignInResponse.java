package com.funix.foodsaverAPI.dto;

public class SignInResponse {
	private String token;

	public SignInResponse(String token) {
		super();
		this.token = token;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}
}
