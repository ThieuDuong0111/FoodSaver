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
public class SearchControllerTest {

	@LocalServerPort
	private int port;

	@Autowired
	private TestRestTemplate restTemplate;

	@MockBean
	private ProductServiceImpl productServiceImpl;

	@Test
	public void testGetProductByName() {
		// Arrange
		String url = "http://localhost:" + port
			+ "/api/search?productName=ProductName";
		String productName = "ProductName";
		ProductDTO productDTO = new ProductDTO(); // Create a mock DTO
		when(productServiceImpl.searchByName(productName))
			.thenReturn(Collections.singletonList(productDTO));

		// Act
		ResponseEntity<?> response = restTemplate.getForEntity(url,
			ProductDTO[].class);

		// Assert
		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getBody()).isNotNull();
	}

	@Test
	public void testGetProductByName_NoResults() {
		// Arrange
		String url = "http://localhost:" + port
			+ "/api/search?productName=NonExistentProduct";
		String productName = "NonExistentProduct";
		when(productServiceImpl.searchByName(productName))
			.thenReturn(Collections.emptyList());

		// Act
		ResponseEntity<?> response = restTemplate.getForEntity(url,
			ProductDTO[].class);

		// Assert
		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
	}
}
