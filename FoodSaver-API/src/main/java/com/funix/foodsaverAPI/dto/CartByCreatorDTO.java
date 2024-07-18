package com.funix.foodsaverAPI.dto;

import java.util.List;

public class CartByCreatorDTO {
	private List<CartItemDTO> cartItems;

	public CartByCreatorDTO() {
		super();
	}

	public CartByCreatorDTO(List<CartItemDTO> cartItems) {
		super();
		this.cartItems = cartItems;
	}

	public List<CartItemDTO> getCartItems() {
		return cartItems;
	}

	public void setCartItems(List<CartItemDTO> cartItems) {
		this.cartItems = cartItems;
	}
}
