package com.funix.foodsaveradmin.repositories;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import com.funix.foodsaveradmin.models.Category;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;
import java.util.Optional;

@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
public class CategoryRepositoryTest {

	@Autowired
	private ICategoryRepository categoryRepository;

	@Test
	public void CategoryRepository_Category_ReturnSaveCategory() {
		Category category = new Category();
		category.setName("Beverage");
		category.setDescription("Drinks and other beverages");

		categoryRepository.save(category);

		Category savedCategory = categoryRepository.save(category);

		assertThat(savedCategory.getName()).isEqualTo("Beverage");
		assertThat(savedCategory.getDescription())
			.isEqualTo("Drinks and other beverages");
	}

	@Test
	public void CategoryRepository_GetAll_ReturnListCategory() {
		Category category1 = new Category();
		category1.setName("Beverage1");
		category1.setDescription("Drinks and other beverages 1");

		Category category2 = new Category();
		category2.setName("Beverage 2");
		category2.setDescription("Drinks and other beverages 2");

		categoryRepository.save(category1);
		categoryRepository.save(category2);

		List<Category> categoryList = categoryRepository.findAll();

		assertThat(categoryList).isNotNull();
	}

	@Test
	public void BannerRepository_FindById_Found() {
		Category category = new Category();
		category.setName("Beverage");
		category.setDescription("Drinks and other beverages");
		categoryRepository.save(category);
		
		Optional<Category> found = categoryRepository
			.findById(category.getId());

		assertThat(found).isPresent();
		assertThat(found.get().getId()).isEqualTo(category.getId());
	}
	
	@Test
	public void BannerRepository_FindById_NotFound() {
		Category category = new Category();
		category.setId(20);
		category.setName("Beverage");
		category.setDescription("Drinks and other beverages");
		categoryRepository.save(category);
		
		Optional<Category> found = categoryRepository
			.findById(21);

		assertThat(found).isNotPresent();
	}

	@Test
	public void CategoryRepository_FindByName_Found() {
		Category category = new Category();
		category.setName("Beverage");
		category.setDescription("Drinks and other beverages");
		categoryRepository.save(category);

		Optional<Category> found = categoryRepository
			.findByName(category.getName());

		assertThat(found).isPresent();
		assertThat(found.get().getName()).isEqualTo(category.getName());
	}

	@Test
	public void CategoryRepository_FindByName_NotFound() {
		Optional<Category> found = categoryRepository.findByName("Nonexistent");
		assertThat(found).isNotPresent();
	}

	@Test
	public void CategoryRepository_UpdateCategory_Success() {
		// Create a new category and save it to the repository
		Category category = new Category();
		category.setName("Confectionery");
		category.setDescription("Sweet treats");
		categoryRepository.save(category);

		// Retrieve the category by name
		Optional<Category> found = categoryRepository
			.findByName("Confectionery");

		// Update the category's name and description
		Category updatedCategory = found.get();
		updatedCategory.setName("UpdatedConfectionery");
		updatedCategory.setDescription("Updated sweet treats");
		categoryRepository.save(updatedCategory);

		// Verify the category was updated correctly
		Optional<Category> foundUpdated = categoryRepository
			.findById(updatedCategory.getId());
		assertThat(foundUpdated).isPresent();
		assertThat(foundUpdated.get().getName())
			.isEqualTo("UpdatedConfectionery");
		assertThat(foundUpdated.get().getDescription())
			.isEqualTo("Updated sweet treats");
	}

	@Test
	public void CategoryRepository_DeleteCategory_Success() {
		// Create a new category and save it to the repository
		Category category = new Category();
		category.setName("Dairy");
		category.setDescription("Milk and milk products");
		categoryRepository.save(category);

		// Delete the category
		categoryRepository.deleteById(category.getId());

		// Verify the category was deleted
		Optional<Category> found = categoryRepository
			.findById(category.getId());
		assertThat(found).isNotPresent();
	}
}
