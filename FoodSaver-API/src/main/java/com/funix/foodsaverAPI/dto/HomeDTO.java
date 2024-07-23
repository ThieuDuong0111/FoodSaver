package com.funix.foodsaverAPI.dto;

import java.util.List;

public class HomeDTO {
	private List<BannerDTO> banners;
	private List<CategoryDTO> categories;
	private List<UserDTO> stores;
	private List<ProductDTO> mostRatingProducts;
	private List<ProductDTO> newestProducts;

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

	public List<ProductDTO> getMostRatingProducts() {
		return mostRatingProducts;
	}

	public void setMostRatingProducts(List<ProductDTO> mostRatingProducts) {
		this.mostRatingProducts = mostRatingProducts;
	}

	public List<ProductDTO> getNewestProducts() {
		return newestProducts;
	}

	public void setNewestProducts(List<ProductDTO> newestProducts) {
		this.newestProducts = newestProducts;
	}

}
