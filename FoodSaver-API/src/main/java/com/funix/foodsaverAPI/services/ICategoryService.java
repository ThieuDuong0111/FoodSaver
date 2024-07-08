package com.funix.foodsaverAPI.services;

import java.util.List;

import com.funix.foodsaverAPI.dto.CategoryDTO;
import com.funix.foodsaverAPI.models.Category;

public interface ICategoryService {

	CategoryDTO convertToDto(Category category);

	Category convertToEntity(CategoryDTO categoryDTO);

	List<CategoryDTO> getAllCategories();

	Category getCategoryById(int id);
	
	Category getCategoryByImageUrl(String url);

	void deleteCategoryById(int id);

}
