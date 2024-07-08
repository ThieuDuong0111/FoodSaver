package com.funix.foodsaveradmin.services;

import java.util.Base64;
import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.funix.foodsaveradmin.dto.CategoryDTO;
import com.funix.foodsaveradmin.models.Category;
import com.funix.foodsaveradmin.repositories.ICategoryRepository;
import com.funix.foodsaveradmin.utils.ImageUtils;
import com.funix.foodsaveradmin.utils.ParseUtils;

@Service
public class CategoryServiceImpl implements ICategoryService {
	@Autowired
	private ICategoryRepository categoryRepository;
	@Autowired
	private ModelMapper modelMapper;

	@Override
	public List<Category> getAllCategories() {
		return categoryRepository.findAll();
	}

	@Override
	public CategoryDTO convertToDto(Category category) {
		return modelMapper.map(category, CategoryDTO.class);
	}

	@Override
	public Category convertToEntity(CategoryDTO categoryDTO) {
		return modelMapper.map(categoryDTO, Category.class);
	}

	@Override
	public void saveCategory(CategoryDTO categoryDTO) {
		// save image file
		if (!categoryDTO.getImageFile().isEmpty()
			&& categoryDTO.getImageFile() != null) {
			MultipartFile image = categoryDTO.getImageFile();
			try {
				categoryDTO.setImage(
					Base64.getEncoder().encodeToString(
						ImageUtils.resizeImage(image.getBytes(), 1000, 1000)));
				categoryDTO.setImageType(image.getContentType());
				String array[] = image.getContentType().split("/");
				String imageUrl = ParseUtils.parseImageUrl(image.getBytes());
				if (array.length > 1) {
					categoryDTO.setImageUrl(
						imageUrl
							+ "." + array[1]);
				} else {
					categoryDTO.setImageUrl(
						imageUrl);
				}

			} catch (Exception e) {
				System.out.println("Upload Image Exception: " + e.getMessage());
			}
		}
		this.categoryRepository.save(convertToEntity(categoryDTO));
	}

	@Override
	public CategoryDTO getCategoryById(int id) {
		Optional<Category> optionalCategory = categoryRepository.findById(id);
		Category category = null;
		if (optionalCategory.isPresent()) {
			category = optionalCategory.get();
		} else {
			throw new RuntimeException("Category not found for id : " + id);
		}
		return convertToDto(category);
	}

	@Override
	public void deleteCategoryById(int id) {
		this.categoryRepository.deleteById(id);

	}

	@Override
	public Page<Category> findPaginated(int pageNum, int pageSize,
		String sortField,
		String sortDirection) {
		Sort sort = sortDirection.equalsIgnoreCase(Sort.Direction.ASC.name())
			? Sort.by(sortField).ascending()
			: Sort.by(sortField).descending();

		Pageable pageable = PageRequest.of(pageNum - 1, pageSize, sort);
		return this.categoryRepository.findAll(pageable);
	}
}
