package com.funix.foodsaverAPI.services;

import java.util.List;

import com.funix.foodsaverAPI.dto.CartItemDTO;
import com.funix.foodsaverAPI.dto.ProductDTO;
import com.funix.foodsaverAPI.models.Product;

public interface IProductService {

	ProductDTO convertToDto(Product product);

	ProductDTO convertFromCartItemToProductDTO(CartItemDTO cartItemDTO);

	List<ProductDTO> getAllProducts();

	Product getProductById(int id);

	List<ProductDTO> getTop20NewestProducts();
	
	List<ProductDTO> getTop5MostPurchaseProducts();

	Product getProductByImageUrl(String url);

	void deleteProductById(int id);

	List<ProductDTO> findByCategoryId(int categoryId);
	
	List<ProductDTO> findByStoreId(int storeId);

	List<ProductDTO> searchByName(String name);
	
	Double calculateRating(int productId);
}
