package com.funix.foodsaveradmin.dto;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.funix.foodsaveradmin.models.Category;
import com.funix.foodsaveradmin.models.MyUser;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;

public class ProductDTO {
	private int id;

	private CategoryDTO category;

	private MyUser creator;

	private List<Category> categories;

	@NotEmpty(message = "Name is required.")
	private String name;

	@NotEmpty(message = "Description is required.")
	private String description;

	private String image;

	private String imageUrl;

	private String imageType;

	private MultipartFile imageFile;

	@Min(value = 1, message = "Price must not be greater than 0")
	private double price;

	@Min(value = 1, message = "Discount price must not be greater than 0")
	private double discountPrice;

	@Min(value = 1, message = "Quantity must not be greater than 0")
	private int quantity;

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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public MultipartFile getImageFile() {
		return imageFile;
	}

	public void setImageFile(MultipartFile imageFile) {
		this.imageFile = imageFile;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public double getDiscountPrice() {
		return discountPrice;
	}

	public void setDiscountPrice(double discountPrice) {
		this.discountPrice = discountPrice;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public List<Category> getCategories() {
		return categories;
	}

	public void setCategories(List<Category> categories) {
		this.categories = categories;
	}

	public CategoryDTO getCategory() {
		return category;
	}

	public void setCategory(CategoryDTO category) {
		this.category = category;
	}

	public MyUser getCreator() {
		return creator;
	}

	public void setCreator(MyUser creator) {
		this.creator = creator;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
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
