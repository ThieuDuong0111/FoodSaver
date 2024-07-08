package com.funix.foodsaverAPI.dto;

import com.funix.foodsaverAPI.models.Role;

public class SignInDTO {
	private String name;
	private String password;
	private String nameError;
	private String passwordError;
	private Boolean hasError;
	private Role role;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Boolean getHasError() {
		return hasError;
	}

	public String getNameError() {
		return nameError;
	}

	public void setNameError(String nameError) {
		this.nameError = nameError;
	}

	public String getPasswordError() {
		return passwordError;
	}

	public void setPasswordError(String passwordError) {
		this.passwordError = passwordError;
	}

	public void setHasError(Boolean hasError) {
		this.hasError = hasError;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}
}
