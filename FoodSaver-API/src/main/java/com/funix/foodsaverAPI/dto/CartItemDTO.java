package com.funix.foodsaverAPI.dto;

public class CartItemDTO {
	private int id;

	private ProductDTO cartProduct;

	private int unitQuantity;

	private double unitPrice;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public ProductDTO getCartProduct() {
		return cartProduct;
	}

	public void setCartProduct(ProductDTO cartProduct) {
		this.cartProduct = cartProduct;
	}

	public int getUnitQuantity() {
		return unitQuantity;
	}

	public void setUnitQuantity(int unitQuantity) {
		this.unitQuantity = unitQuantity;
	}

	public double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}
}
