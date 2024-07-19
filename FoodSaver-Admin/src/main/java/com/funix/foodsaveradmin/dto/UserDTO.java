package com.funix.foodsaveradmin.dto;

import org.springframework.web.multipart.MultipartFile;

import com.funix.foodsaveradmin.models.Role;

import jakarta.validation.constraints.NotEmpty;

public class UserDTO {

	private int id;

	@NotEmpty(message = "Tên không được bỏ trống.")
	private String name;

	@NotEmpty(message = "Tên cửa hàng không được bỏ trống.")
	private String storeName;

	private String avatar;

	private String imageUrl;

	private String imageType;

	private String storeImage;

	private String storeImageUrl;

	private String storeImageType;

	@NotEmpty(message = "Mật khẩu không được bỏ trống.")
	private String password;

	@NotEmpty(message = "Email không được bỏ trống.")
	private String email;

	@NotEmpty(message = "Số điện thoại không được bỏ trống.")
	private String phone;

	@NotEmpty(message = "Địa chỉ không được bỏ trống.")
	private String address;

	private String storeDescription;

	private Role role;

	private MultipartFile imageFile;

	private MultipartFile imageStoreFile;

	public UserDTO() {
		super();
	}

	public UserDTO(
		@NotEmpty(message = "Tên không được bỏ trống.") String name,
		@NotEmpty(message = "Mật khẩu không được bỏ trống.") String password,
		@NotEmpty(message = "Email không được bỏ trống.") String email,
		@NotEmpty(message = "Số điện thoại không được bỏ trống.") String phone,
		@NotEmpty(message = "Địa chỉ không được bỏ trống.") String address) {
		super();
		this.name = name;
		this.password = password;
		this.email = email;
		this.phone = phone;
		this.address = address;

	}

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

	public String getStoreImage() {
		return storeImage;
	}

	public void setStoreImage(String storeImage) {
		this.storeImage = storeImage;
	}

	public String getStoreImageUrl() {
		return storeImageUrl;
	}

	public void setStoreImageUrl(String storeImageUrl) {
		this.storeImageUrl = storeImageUrl;
	}

	public String getStoreImageType() {
		return storeImageType;
	}

	public void setStoreImageType(String storeImageType) {
		this.storeImageType = storeImageType;
	}

	public String getStoreDescription() {
		return storeDescription;
	}

	public void setStoreDescription(String storeDescription) {
		this.storeDescription = storeDescription;
	}

	public MultipartFile getImageStoreFile() {
		return imageStoreFile;
	}

	public void setImageStoreFile(MultipartFile imageStoreFile) {
		this.imageStoreFile = imageStoreFile;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
}
