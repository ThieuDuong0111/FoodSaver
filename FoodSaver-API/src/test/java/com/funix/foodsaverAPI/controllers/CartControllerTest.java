package com.funix.foodsaverAPI.controllers;

import static org.assertj.core.api.Assertions.assertThat;

import java.text.ParseException;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.funix.foodsaverAPI.dto.CartItemDTO;
import com.funix.foodsaverAPI.dto.CartItemProductDTO;

@ExtendWith(SpringExtension.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class CartControllerTest {

	@LocalServerPort
	private int port;

	@Autowired
	private TestRestTemplate restTemplate;

	@Test
	public void testGetItems() {
		// Arrange
		String url = "http://localhost:" + port + "/api/cart/get-items";

		// Act
		ResponseEntity<?> response = restTemplate.getForEntity(url,
			Object.class);

		// Assert
		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.FORBIDDEN);
		assertThat(response.getBody()).isNull();
	}

	@Test
	public void testUpdateItem() {
		// Arrange
		String url = "http://localhost:" + port + "/api/cart/update-item";
		CartItemProductDTO cartItemProductDTO = new CartItemProductDTO();
		HttpEntity<CartItemProductDTO> request = new HttpEntity<>(
			cartItemProductDTO);

		// Act
		ResponseEntity<?> response = restTemplate.exchange(url, HttpMethod.POST,
			request, Object.class);

		// Assert
		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.FORBIDDEN);
		assertThat(response.getBody()).isNull();
	}

	@Test
	public void testDeleteItem() {
		// Arrange
		String url = "http://localhost:" + port + "/api/cart/delete-item";
		CartItemDTO cartItemDTO = new CartItemDTO();
		HttpEntity<CartItemDTO> request = new HttpEntity<>(cartItemDTO);

		// Act
		ResponseEntity<?> response = restTemplate.exchange(url,
			HttpMethod.DELETE, request, Object.class);

		// Assert
		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.FORBIDDEN);
		assertThat(response.getBody()).isNull();
	}

	@Test
	public void testCheckoutSuccess() throws ParseException {
		// Arrange
		String url = "http://localhost:" + port + "/api/cart/checkout";

		// Act
		ResponseEntity<?> response = restTemplate.postForEntity(url, null,
			Object.class);

		// Assert
		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.FORBIDDEN);
		assertThat(response.getBody()).isNull();
	}

}
