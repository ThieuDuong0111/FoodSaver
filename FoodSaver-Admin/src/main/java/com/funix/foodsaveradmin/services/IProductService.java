package com.funix.foodsaveradmin.services;

import org.springframework.data.domain.Page;

import com.funix.foodsaveradmin.dto.ProductDTO;
import com.funix.foodsaveradmin.models.Product;

public interface IProductService {

	ProductDTO convertToDto(Product product);

	Product convertToEntity(ProductDTO productDTO);

	void saveProduct(ProductDTO productDTO);

	ProductDTO getProductById(int id);

	void deleteProductById(int id);

	Page<Product> findPaginated(int pageNum, int pageSize,
		String sortField,
		String sortDirection, int creator_id);
}
