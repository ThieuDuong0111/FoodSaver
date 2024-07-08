package com.funix.foodsaverAPI.dto;

import java.util.List;

public class HomeDTO {
	private List<CategoryDTO> categories;
	private List<ProductDTO> products;

	public List<CategoryDTO> getCategories() {
		return categories;
	}

	public void setCategories(List<CategoryDTO> categories) {
		this.categories = categories;
	}

	public List<ProductDTO> getProducts() {
		return products;
	}

	public void setProducts(List<ProductDTO> products) {
		this.products = products;
	}
}
