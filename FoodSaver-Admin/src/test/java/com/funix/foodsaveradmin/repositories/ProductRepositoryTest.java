package com.funix.foodsaveradmin.repositories;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import com.funix.foodsaveradmin.models.Category;
import com.funix.foodsaveradmin.models.MyUser;
import com.funix.foodsaveradmin.models.Product;
import com.funix.foodsaveradmin.models.Unit;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
public class ProductRepositoryTest {

	@Autowired
	private IProductRepository productRepository;

	@Autowired
	private ICategoryRepository categoryRepository;

	@Autowired
	private IUserRepository userRepository;

	@Autowired
	private IUnitRepository unitRepository;

	@Test
	public void ProductRepository_Save_ReturnProduct() {
		// Create a new category
		Category category = new Category();
		category.setName("Beverages");
		category.setDescription("Drinks and other beverages");
		categoryRepository.save(category);

		// Create a new user
		MyUser creator = new MyUser();
		creator.setName("creatorUser");
		creator.setPassword("password");
		creator.setPhone("1234567890");
		creator.setEmail("creator@example.com");
		creator.setAddress("123 Creator St.");
		userRepository.save(creator);

		// Create a new unit
		Unit unit = new Unit();
		unit.setName("Bottle");
		unitRepository.save(unit);

		// Create a new product and save it to the repository
		Product product = new Product();
		product.setName("Cola");
		product.setDescription("Carbonated soft drink");
		product.setCategory(category);
		product.setCreator(creator);
		product.setUnit(unit);
		product.setPrice(1.99);
		product.setDiscountPrice(1.49);
		product.setQuantity(100);
		product.setExpiredDate(new Date());
		productRepository.save(product);

		// Retrieve the product by name
		Optional<Product> found = productRepository.findByName("Cola");

		// Verify the product was saved correctly
		assertThat(found).isPresent();
		assertThat(found.get().getName()).isEqualTo("Cola");
		assertThat(found.get().getDescription())
			.isEqualTo("Carbonated soft drink");
		assertThat(found.get().getCategory().getName()).isEqualTo("Beverages");
		assertThat(found.get().getCreator().getName()).isEqualTo("creatorUser");
		assertThat(found.get().getUnit().getName()).isEqualTo("Bottle");
	}

	@Test
	public void ProductRepository_GetAll_ReturnListProduct() {
		// Create a new category
		Category category = new Category();
		category.setName("Beverages");
		category.setDescription("Drinks and other beverages");
		categoryRepository.save(category);

		// Create a new user
		MyUser creator = new MyUser();
		creator.setName("creatorUser");
		creator.setPassword("password");
		creator.setPhone("1234567890");
		creator.setEmail("creator@example.com");
		creator.setAddress("123 Creator St.");
		userRepository.save(creator);

		// Create a new unit
		Unit unit = new Unit();
		unit.setName("Bottle");
		unitRepository.save(unit);

		// Create a new product and save it to the repository
		Product product1 = new Product();
		product1.setName("Cola");
		product1.setDescription("Carbonated soft drink");
		product1.setCategory(category);
		product1.setCreator(creator);
		product1.setUnit(unit);
		product1.setPrice(1.99);
		product1.setDiscountPrice(1.49);
		product1.setQuantity(100);
		product1.setExpiredDate(new Date());

		Product product2 = new Product();
		product2.setName("Cola");
		product2.setDescription("Carbonated soft drink");
		product2.setCategory(category);
		product2.setCreator(creator);
		product2.setUnit(unit);
		product2.setPrice(1.99);
		product2.setDiscountPrice(1.49);
		product2.setQuantity(100);
		product2.setExpiredDate(new Date());

		productRepository.save(product1);
		productRepository.save(product2);

		List<Product> productList = productRepository.findAll();

		assertThat(productList).isNotNull();
	}

	@Test
	public void ProductRepository_FindById_Found() {
		// Create and save a new product
		Product product = new Product();
		product.setName("Water");
		product.setDescription("Bottled water");
		productRepository.save(product);

		// Retrieve the product by ID
		Optional<Product> found = productRepository.findById(product.getId());

		// Verify the product was found and the ID is correct
		assertThat(found).isPresent();
		assertThat(found.get().getId()).isEqualTo(product.getId());
	}

	@Test
	public void ProductRepository_FindById_NotFound() {
		// Retrieve the product by ID
		Optional<Product> found = productRepository.findById(500);

		// Verify the product was found and the ID is correct
		assertThat(found).isNotPresent();
	}

	@Test
	public void ProductRepository_FindByName_Found() {
		// Create and save a new product
		Product product = new Product();
		product.setName("Juice");
		product.setDescription("Fruit juice");
		productRepository.save(product);

		// Retrieve the product by name
		Optional<Product> found = productRepository.findByName("Juice");

		// Verify the product was found and the name is correct
		assertThat(found).isPresent();
		assertThat(found.get().getName()).isEqualTo("Juice");
	}

	@Test
	public void ProductRepository_FindByName_NotFound() {
		// Attempt to find a product that doesn't exist
		Optional<Product> found = productRepository.findByName("Nonexistent");

		// Verify no product is found
		assertThat(found).isNotPresent();
	}

	@Test
	public void ProductRepository_UpdateProduct_Success() {
		// Create and save a new product
		Product product = new Product();
		product.setName("Soda");
		product.setDescription("Soft drink");
		productRepository.save(product);

		// Retrieve the product by name
		Optional<Product> found = productRepository.findByName("Soda");

		// Update the product's details
		Product updatedProduct = found.get();
		updatedProduct.setName("UpdatedSoda");
		updatedProduct.setDescription("Updated soft drink");
		productRepository.save(updatedProduct);

		// Verify the product was updated correctly
		Optional<Product> foundUpdated = productRepository
			.findById(updatedProduct.getId());
		assertThat(foundUpdated).isPresent();
		assertThat(foundUpdated.get().getName()).isEqualTo("UpdatedSoda");
		assertThat(foundUpdated.get().getDescription())
			.isEqualTo("Updated soft drink");
	}

	@Test
	public void ProductRepository_DeleteProduct_Success() {
		// Create and save a new product
		Product product = new Product();
		product.setName("Milk");
		product.setDescription("Dairy milk");
		productRepository.save(product);

		// Delete the product
		productRepository.deleteById(product.getId());

		// Verify the product was deleted
		Optional<Product> found = productRepository.findById(product.getId());
		assertThat(found).isNotPresent();
	}
}
