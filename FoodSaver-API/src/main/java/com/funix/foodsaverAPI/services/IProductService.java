package com.funix.foodsaverAPI.services;

import java.util.List;

import com.funix.foodsaverAPI.dto.ProductDTO;
import com.funix.foodsaverAPI.models.Product;

public interface IProductService {
	ProductDTO convertToDto(Product product);

	List<ProductDTO> getAllProducts();

	Product getProductById(int id);

	List<ProductDTO> getTop20Products();

	Product getProductByImageUrl(String url);

	void deleteProductById(int id);
}
