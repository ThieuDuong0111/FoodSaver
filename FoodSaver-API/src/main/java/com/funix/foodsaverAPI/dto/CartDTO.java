package com.funix.foodsaverAPI.dto;

import java.util.Date;
import java.util.List;

public class CartDTO {
	private int id;

	private List<CartItemDTO> cartItems;

	private UserDTO userCarts;

	private Date publishedDate;

	private Boolean isDone;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getPublishedDate() {
		return publishedDate;
	}

	public void setPublishedDate(Date publishedDate) {
		this.publishedDate = publishedDate;
	}

	public List<CartItemDTO> getCartItems() {
		return cartItems;
	}

	public void setCartItems(List<CartItemDTO> cartItems) {
		this.cartItems = cartItems;
	}

	public UserDTO getUserCarts() {
		return userCarts;
	}

	public void setUserCarts(UserDTO userCarts) {
		this.userCarts = userCarts;
	}

	public Boolean getIsDone() {
		return isDone;
	}

	public void setIsDone(Boolean isDone) {
		this.isDone = isDone;
	}
}
