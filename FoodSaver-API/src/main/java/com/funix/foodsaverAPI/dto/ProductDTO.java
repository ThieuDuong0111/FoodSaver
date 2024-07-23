package com.funix.foodsaverAPI.dto;

import java.util.Date;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;

public class ProductDTO {
	private int id;

	private CategoryDTO category;

	private UserDTO creator;

	private UnitDTO unit;

	@NotEmpty(message = "Name không được bỏ trống.")
	private String name;

	@NotEmpty(message = "Description không được bỏ trống.")
	private String description;

	@Min(value = 1, message = "Số tiền phải lớn hơn 0")
	private double price;

	@Min(value = 1, message = "Số tiền phải lớn hơn 0")
	private double discountPrice;

	@Min(value = 1, message = "Số lượng phải lớn hơn 0")
	private int quantity;

	private Double rating;

	private int commentsCount;

	private int ratingsCount;

	private int rating5Count;

	private int rating4Count;

	private int rating3Count;

	private int rating2Count;

	private int rating1Count;

	private String imageUrl;

	private Date expiredDate;

	private Boolean isExpired;

	private Boolean isOutOfStock;

	private int soldCount;

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

	public UserDTO getCreator() {
		return creator;
	}

	public void setCreator(UserDTO creator) {
		this.creator = creator;
	}

	public CategoryDTO getCategory() {
		return category;
	}

	public void setCategory(CategoryDTO category) {
		this.category = category;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public Double getRating() {
		return rating;
	}

	public void setRating(Double rating) {
		this.rating = rating;
	}

	public int getCommentsCount() {
		return commentsCount;
	}

	public void setCommentsCount(int commentsCount) {
		this.commentsCount = commentsCount;
	}

	public UnitDTO getUnit() {
		return unit;
	}

	public void setUnit(UnitDTO unit) {
		this.unit = unit;
	}

	public Date getExpiredDate() {
		return expiredDate;
	}

	public void setExpiredDate(Date expiredDate) {
		this.expiredDate = expiredDate;
	}

	public Boolean getIsExpired() {
		return isExpired;
	}

	public void setIsExpired(Boolean isExpired) {
		this.isExpired = isExpired;
	}

	public Boolean getIsOutOfStock() {
		return isOutOfStock;
	}

	public void setIsOutOfStock(Boolean isOutOfStock) {
		this.isOutOfStock = isOutOfStock;
	}

	public int getRatingsCount() {
		return ratingsCount;
	}

	public void setRatingsCount(int ratingsCount) {
		this.ratingsCount = ratingsCount;
	}

	public int getRating5Count() {
		return rating5Count;
	}

	public void setRating5Count(int rating5Count) {
		this.rating5Count = rating5Count;
	}

	public int getRating4Count() {
		return rating4Count;
	}

	public void setRating4Count(int rating4Count) {
		this.rating4Count = rating4Count;
	}

	public int getRating3Count() {
		return rating3Count;
	}

	public void setRating3Count(int rating3Count) {
		this.rating3Count = rating3Count;
	}

	public int getRating2Count() {
		return rating2Count;
	}

	public void setRating2Count(int rating2Count) {
		this.rating2Count = rating2Count;
	}

	public int getRating1Count() {
		return rating1Count;
	}

	public void setRating1Count(int rating1Count) {
		this.rating1Count = rating1Count;
	}

	public int getSoldCount() {
		return soldCount;
	}

	public void setSoldCount(int soldCount) {
		this.soldCount = soldCount;
	}
}
