package com.funix.foodsaveradmin.dto;

import org.springframework.web.multipart.MultipartFile;

import com.funix.foodsaveradmin.models.Role;

import jakarta.validation.constraints.NotEmpty;

public class UserDTO {

	private int id;

	@NotEmpty(message = "Name is required.")
	private String name;

	private String avatar;

	private String imageUrl;

	private String imageType;

	@NotEmpty(message = "Password is required.")
	private String password;

	@NotEmpty(message = "Email is required.")
	private String email;

	@NotEmpty(message = "Phone is required.")
	private String phone;

	@NotEmpty(message = "Address is required.")
	private String address;

	private Role role;

	private MultipartFile imageFile;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public MultipartFile getImageFile() {
		return imageFile;
	}

	public void setImageFile(MultipartFile imageFile) {
		this.imageFile = imageFile;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getImageType() {
		return imageType;
	}

	public void setImageType(String imageType) {
		this.imageType = imageType;
	}
}
