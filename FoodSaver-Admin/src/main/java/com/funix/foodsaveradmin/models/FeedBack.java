package com.funix.foodsaveradmin.models;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

import java.util.Date;

@Entity
public class FeedBack {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@ManyToOne
	@JoinColumn(name = "user_id", nullable = false)
	private MyUser userFeedBacks;

	@ManyToOne
	@JoinColumn(name = "product_id", nullable = false)
	private Product productFeedBacks;

	private String comment;

	private Date publishedDate;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public MyUser getUserFeedBacks() {
		return userFeedBacks;
	}

	public void setUserFeedBacks(MyUser userFeedBacks) {
		this.userFeedBacks = userFeedBacks;
	}

	public Product getProductFeedBacks() {
		return productFeedBacks;
	}

	public void setProductFeedBacks(Product productFeedBacks) {
		this.productFeedBacks = productFeedBacks;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Date getPublishedDate() {
		return publishedDate;
	}

	public void setPublishedDate(Date publishedDate) {
		this.publishedDate = publishedDate;
	}
}
