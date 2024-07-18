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
import org.springframework.web.multipart.MultipartFile;

import static org.mockito.Mockito.*;

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
	public void testSaveCategory() {
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
	public void testDeleteCategoryById() {
		// Given
		int categoryId = 1;
		// When
		categoryService.deleteCategoryById(categoryId);
		// Then
		verify(categoryRepository, times(1)).deleteById(categoryId);
	}
}
