package com.funix.foodsaveradmin.repositories;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import com.funix.foodsaveradmin.models.Category;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.Optional;

@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
public class CategoryRepositoryTest {

	@Autowired
	private ICategoryRepository categoryRepository;

	@Test
	public void testSaveCategory() {
		// Create a new category and save it to the repository
		Category category = new Category();
		category.setName("Beverage");
		category.setDescription("Drinks and other beverages");
		categoryRepository.save(category);

		// Retrieve the category by name
		Optional<Category> found = categoryRepository.findByName("Beverage");

		// Verify the category was saved correctly
		assertThat(found).isPresent();
		assertThat(found.get().getName()).isEqualTo("Beverage");
		assertThat(found.get().getDescription())
			.isEqualTo("Drinks and other beverages");
	}

	@Test
	public void testFindByName() {
		// Create a new category and save it to the repository
		Category category = new Category();
		category.setName("Food");
		category.setDescription("Various food items");
		categoryRepository.save(category);

		// Retrieve the category by name
		Optional<Category> found = categoryRepository.findByName("Food");

		// Verify the category was found and the name is correct
		assertThat(found).isPresent();
		assertThat(found.get().getName()).isEqualTo("Food");
	}

	@Test
	public void testFindByName_NotFound() {
		// Attempt to find a category that doesn't exist
		Optional<Category> found = categoryRepository.findByName("Nonexistent");

		// Verify no category is found
		assertThat(found).isNotPresent();
	}

	@Test
	public void testFindById() {
		// Create a new category and save it to the repository
		Category category = new Category();
		category.setName("Snacks");
		category.setDescription("Various snacks");
		categoryRepository.save(category);

		// Retrieve the category by ID
		Optional<Category> found = categoryRepository
			.findById(category.getId());

		// Verify the category was found and the ID is correct
		assertThat(found).isPresent();
		assertThat(found.get().getId()).isEqualTo(category.getId());
	}

	@Test
	public void testUpdateCategory() {
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
	public void testDeleteCategory() {
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
