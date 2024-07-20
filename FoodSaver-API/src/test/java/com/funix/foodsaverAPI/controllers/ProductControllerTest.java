package com.funix.foodsaverAPI.controllers;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.when;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.funix.foodsaverAPI.dto.ProductDTO;
import com.funix.foodsaverAPI.services.ProductServiceImpl;

import java.util.Collections;

@ExtendWith(SpringExtension.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class ProductControllerTest {

	@LocalServerPort
	private int port;

	@Autowired
	private TestRestTemplate restTemplate;

	@MockBean
	private ProductServiceImpl productServiceImpl;

	@Test
	public void testGetAllProducts() {
		// Arrange
		String url = "http://localhost:" + port + "/api/products/all";
		ProductDTO productDTO = new ProductDTO(); // Create a mock DTO
		when(productServiceImpl.getAllProducts())
			.thenReturn(Collections.singletonList(productDTO));

		// Act
		ResponseEntity<?> response = restTemplate.getForEntity(url,
			ProductDTO[].class);

		// Assert
		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody()).isNotNull();
	}

	@Test
	public void testGetProductDetail() {
		// Arrange
		int productId = 1;
		String url = "http://localhost:" + port + "/api/product/" + productId;
		ProductDTO productDTO = new ProductDTO(); // Create a mock DTO
		when(productServiceImpl
			.convertToDto(productServiceImpl.getProductById(productId)))
			.thenReturn(productDTO);

		// Act
		ResponseEntity<?> response = restTemplate.getForEntity(url,
			ProductDTO.class);

		// Assert
		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
	}

	@Test
	public void testGetProductDetail_NotFound() {
		// Arrange
		int productId = 2;
		String url = "http://localhost:" + port + "/api/product/" + productId;
		when(productServiceImpl
			.convertToDto(productServiceImpl.getProductById(productId)))
			.thenReturn(null);

		// Act
		ResponseEntity<?> response = restTemplate.getForEntity(url,
			ProductDTO.class);

		// Assert
		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
	}

	@Test
	public void testGetProductByCategoryId() {
		// Arrange
		int categoryId = 1;
		String url = "http://localhost:" + port + "/api/products/by-category/"
			+ categoryId;
		ProductDTO productDTO = new ProductDTO(); // Create a mock DTO
		when(productServiceImpl.findByCategoryId(categoryId))
			.thenReturn(Collections.singletonList(productDTO));

		// Act
		ResponseEntity<?> response = restTemplate.getForEntity(url,
			ProductDTO[].class);

		// Assert
		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody()).isNotNull();
	}

	@Test
	public void testGetProductByStoreId() {
		// Arrange
		int storeId = 1;
		String url = "http://localhost:" + port + "/api/products/by-store/"
			+ storeId;
		ProductDTO productDTO = new ProductDTO(); // Create a mock DTO
		when(productServiceImpl.findByStoreId(storeId))
			.thenReturn(Collections.singletonList(productDTO));

		// Act
		ResponseEntity<?> response = restTemplate.getForEntity(url,
			ProductDTO[].class);

		// Assert
		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody()).isNotNull();
	}
}
