package com.funix.foodsaverAPI.dto;

import java.util.List;

public class HomeDTO {
	private List<BannerDTO> banners;
	private List<CategoryDTO> categories;
	private List<ProductDTO> products;

	public List<BannerDTO> getBanners() {
		return banners;
	}

	public void setBanners(List<BannerDTO> banners) {
		this.banners = banners;
	}

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
