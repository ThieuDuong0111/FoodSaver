package com.funix.foodsaverAPI.dto;

import java.util.List;

public class HomeDTO {
	private List<BannerDTO> banners;
	private List<CategoryDTO> categories;
	private List<UserDTO> stores;
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

	public List<UserDTO> getStores() {
		return stores;
	}

	public void setStores(List<UserDTO> stores) {
		this.stores = stores;
	}

	public List<ProductDTO> getProducts() {
		return products;
	}

	public void setProducts(List<ProductDTO> products) {
		this.products = products;
	}
}
