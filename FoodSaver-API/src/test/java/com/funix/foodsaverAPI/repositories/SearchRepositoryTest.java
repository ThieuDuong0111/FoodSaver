package com.funix.foodsaverAPI.repositories;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.Date;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import com.funix.foodsaverAPI.models.Product;

@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
public class SearchRepositoryTest {

	@Autowired
	private IProductRepository productRepository;

	@Test
	public void SearchRepository_GetProducts_Found() {

		// Create a new product and save it to the repository
		Product product = new Product();
		product.setName("CocaCola 1");
		product.setDescription("Carbonated soft drink");
		product.setPrice(1.99);
		product.setDiscountPrice(1.49);
		product.setQuantity(100);
		product.setExpiredDate(new Date());
		productRepository.save(product);

		Product product1 = new Product();
		product1.setName("CocaCola 2");
		product1.setDescription("Carbonated soft drink");
		product1.setPrice(1.99);
		product1.setDiscountPrice(1.49);
		product1.setQuantity(100);
		product1.setExpiredDate(new Date());
		productRepository.save(product);

		List<Product> productSearch = productRepository.searchByName("Cola");
		assertThat(productSearch).size().isEqualTo(2);
	}

	@Test
	public void SearchRepository_GetProducts_NotFound() {
		// Create a new product and save it to the repository
		Product product = new Product();
		product.setName("CocaCola 1");
		product.setDescription("Carbonated soft drink");
		product.setPrice(1.99);
		product.setDiscountPrice(1.49);
		product.setQuantity(100);
		product.setExpiredDate(new Date());
		productRepository.save(product);

		Product product1 = new Product();
		product1.setName("CocaCola 2");
		product1.setDescription("Carbonated soft drink");
		product1.setPrice(1.99);
		product1.setDiscountPrice(1.49);
		product1.setQuantity(100);
		product1.setExpiredDate(new Date());
		productRepository.save(product);

		List<Product> productSearch = productRepository.searchByName("Pepsi");
		assertThat(productSearch).size().isEqualTo(0);
	}

}
