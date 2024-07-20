package com.funix.foodsaveradmin.services;

import com.funix.foodsaveradmin.dto.CategoryDTO;
import com.funix.foodsaveradmin.models.Category;
import com.funix.foodsaveradmin.repositories.ICategoryRepository;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.modelmapper.ModelMapper;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.web.multipart.MultipartFile;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertAll;
import static org.mockito.Mockito.*;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
public class CategoryServiceImplTest {

	@Mock
	private ICategoryRepository categoryRepository;

	@Mock
	private ModelMapper modelMapper;

	@InjectMocks
	private CategoryServiceImpl categoryService;

	@Test
	public void CategoryService_SaveCategory_ReturnCategory() {
		// Given
		CategoryDTO categoryDTO = new CategoryDTO();
		categoryDTO.setName("Test Category");
		MultipartFile imageFile = Mockito.mock(MultipartFile.class);
		categoryDTO.setImageFile(imageFile);

		// Mocking image processing
		when(imageFile.isEmpty()).thenReturn(false);
		when(imageFile.getContentType()).thenReturn("image/jpeg");
		categoryDTO.setImageType("image/jpeg");

		// Mocking repository save method
		when(modelMapper.map(categoryDTO, Category.class))
			.thenReturn(new Category());
		when(categoryRepository.save(Mockito.any(Category.class)))
			.thenReturn(new Category());

		// When
		categoryService.saveCategory(categoryDTO);

		// Then
		verify(categoryRepository, times(1)).save(Mockito.any(Category.class));
	}

	@Test
	public void CategoryService_WhenGetAll_shouldReturnList() {
		// Mocking repository response
		Category category1 = new Category(1, "Category 1", "Description 1");
		Category category2 = new Category(2, "Category 2", "Description 2");
		List<Category> categories = Arrays.asList(category1, category2);
		when(categoryRepository.findAll()).thenReturn(categories);

		// Calling service method
		List<Category> result = categoryService.getAllCategories();

		// Asserting the result
		assertThat(result).hasSize(2);
		assertThat(result).contains(category1, category2);
	}

	@Test
	public void CategoryService_FindById_ReturnCategory() {
		int categoryId = 1;
		Category category = new Category(categoryId, "Category 1",
			"Description 1");
		when(categoryRepository.findById(categoryId))
			.thenReturn(Optional.ofNullable(category));

		Category findCategory = categoryService.getCategoryById(categoryId);

		assertThat(findCategory).isNotNull();
	}

	@Test
	public void CategoryService_DeleteCategoryById() {
		// Given
		int categoryId = 1;
		// When
		doNothing().when(categoryRepository).deleteById(categoryId);

		// Calling service method
		categoryService.deleteCategoryById(categoryId);
		assertAll(() -> categoryService.deleteCategoryById(categoryId));
	}
	
	@Test
	public void CategoryService_FindPaginatedCategories() {
		// Mocking repository response
		int pageNum = 1;
		int pageSize = 10;
		String sortField = "name";
		String sortDirection = "ASC";
		Sort sort = Sort.by(Sort.Direction.fromString(sortDirection),
			sortField);
		Pageable pageable = PageRequest.of(pageNum - 1, pageSize, sort);
		Category category1 = new Category(1, "Category 1", "Description 1");
		Category category2 = new Category(2, "Category 2", "Description 2");
		List<Category> categories = Arrays.asList(category1, category2);
		Page<Category> page = new PageImpl<>(categories, pageable, categories.size());
		when(categoryRepository.findAll(pageable)).thenReturn(page);

		// Calling service method
		Page<Category> resultPage = categoryService.findPaginated(pageNum, pageSize,
			sortField, sortDirection);

		// Asserting the result
		assertThat(resultPage).isNotNull();
		assertThat(resultPage.getContent()).hasSize(2);
		assertThat(resultPage.getContent()).contains(category1, category2);
	}
}
