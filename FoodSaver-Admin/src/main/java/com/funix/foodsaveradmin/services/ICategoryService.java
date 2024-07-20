package com.funix.foodsaveradmin.services;

import java.util.List;

import org.springframework.data.domain.Page;

import com.funix.foodsaveradmin.dto.CategoryDTO;
import com.funix.foodsaveradmin.models.Category;

public interface ICategoryService {

	CategoryDTO convertToDto(Category category);

	Category convertToEntity(CategoryDTO categoryDTO);

	List<Category> getAllCategories();

	void saveCategory(CategoryDTO categoryDTO);

	Category getCategoryById(int id);

	void deleteCategoryById(int id);

	Page<Category> findPaginated(int pageNum, int pageSize,
		String sortField,
		String sortDirection);
}
