package com.funix.foodsaverAPI.services;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.funix.foodsaverAPI.dto.CategoryDTO;
import com.funix.foodsaverAPI.models.Category;
import com.funix.foodsaverAPI.repositories.ICategoryRepository;

@Service
public class CategoryServiceImpl implements ICategoryService {
	
	@Autowired
	private ICategoryRepository categoryRepository;
	
	@Autowired
	private ModelMapper modelMapper;

	@Override
	public List<CategoryDTO> getAllCategories() {
		return categoryRepository.findAll().stream()
			.map(this::convertToDto)
			.collect(Collectors.toList());
	}

	@Override
	public CategoryDTO convertToDto(Category category) {
		CategoryDTO categoryDTO = modelMapper.map(category, CategoryDTO.class);
		if (category.getImageUrl() != null) {
			categoryDTO.setImageUrl("http://localhost:8080/api/image/category/"
				+ category.getImageUrl());
		}
		return categoryDTO;
	}

	@Override
	public Category convertToEntity(CategoryDTO categoryDTO) {
		return modelMapper.map(categoryDTO, Category.class);
	}

	@Override
	public Category getCategoryById(int id) {
		Optional<Category> optionalCategory = categoryRepository.findById(id);
		Category category = null;
		if (optionalCategory.isPresent()) {
			category = optionalCategory.get();
		}
		return category;
	}

	@Override
	public void deleteCategoryById(int id) {
		this.categoryRepository.deleteById(id);
	}

	@Override
	public Category getCategoryByImageUrl(String url) {
		Optional<Category> optionalCategory = categoryRepository
			.findByImageUrl(url);
		Category category = null;
		if (optionalCategory.isPresent()) {
			category = optionalCategory.get();
			return category;
		} else {
			return null;
		}

	}
}
