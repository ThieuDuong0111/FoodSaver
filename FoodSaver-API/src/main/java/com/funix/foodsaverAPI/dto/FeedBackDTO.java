package com.funix.foodsaverAPI.dto;

import java.util.Date;

public class FeedBackDTO {
	private int id;

	private UserDTO userFeedBacks;

	private ProductDTO productFeedBacks;

	private String comment;

	private int rating;

	private Date publishedDate;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public UserDTO getUserFeedBacks() {
		return userFeedBacks;
	}

	public void setUserFeedBacks(UserDTO userFeedBacks) {
		this.userFeedBacks = userFeedBacks;
	}

	public ProductDTO getProductFeedBacks() {
		return productFeedBacks;
	}

	public void setProductFeedBacks(ProductDTO productFeedBacks) {
		this.productFeedBacks = productFeedBacks;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public Date getPublishedDate() {
		return publishedDate;
	}

	public void setPublishedDate(Date publishedDate) {
		this.publishedDate = publishedDate;
	}
}
