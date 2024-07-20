package com.funix.foodsaverAPI.controllers;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.when;

import java.util.Base64;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.funix.foodsaverAPI.models.Banner;
import com.funix.foodsaverAPI.models.Category;
import com.funix.foodsaverAPI.models.MyUser;
import com.funix.foodsaverAPI.models.OrderDetail;
import com.funix.foodsaverAPI.models.Product;
import com.funix.foodsaverAPI.services.BannerServiceImpl;
import com.funix.foodsaverAPI.services.CategoryServiceImpl;
import com.funix.foodsaverAPI.services.OrderDetailServiceImpl;
import com.funix.foodsaverAPI.services.ProductServiceImpl;
import com.funix.foodsaverAPI.services.UserServiceImpl;

@ExtendWith(SpringExtension.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class ImageControllerTest {

	@LocalServerPort
	private int port;

	@Autowired
	private TestRestTemplate restTemplate;

	@MockBean
	private UserServiceImpl userServiceImpl;

	@MockBean
	private ProductServiceImpl productServiceImpl;

	@MockBean
	private CategoryServiceImpl categoryServiceImpl;

	@MockBean
	private BannerServiceImpl bannerServiceImpl;

	@MockBean
	private OrderDetailServiceImpl orderDetailServiceImpl;

	@Test
	public void testGetImageUserByUrl() {
		// Arrange
		String url = "http://localhost:" + port + "/api/image/user/avatar.png";
		MyUser user = new MyUser();
		user.setAvatar(
			Base64.getEncoder().encodeToString("user-avatar".getBytes()));
		user.setImageType("image/png");
		when(userServiceImpl.getUserByImageUrl("avatar.png")).thenReturn(user);

		// Act
		ResponseEntity<byte[]> response = restTemplate.getForEntity(url,
			byte[].class);

		// Assert
		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getHeaders().getContentType())
			.isEqualTo(MediaType.IMAGE_PNG);
		assertThat(response.getBody()).isEqualTo("user-avatar".getBytes());
	}

	@Test
	public void testGetStoreImageUserByUrl() {
		// Arrange
		String url = "http://localhost:" + port + "/api/image/store/store.png";
		MyUser user = new MyUser();
		user.setStoreImage(
			Base64.getEncoder().encodeToString("store-image".getBytes()));
		user.setStoreImageType("image/png");
		when(userServiceImpl.getUserByStoreImageUrl("store.png"))
			.thenReturn(user);

		// Act
		ResponseEntity<byte[]> response = restTemplate.getForEntity(url,
			byte[].class);

		// Assert
		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getHeaders().getContentType())
			.isEqualTo(MediaType.IMAGE_PNG);
		assertThat(response.getBody()).isEqualTo("store-image".getBytes());
	}

	@Test
	public void testGetImageCategoryByUrl() {
		// Arrange
		String url = "http://localhost:" + port
			+ "/api/image/category/category.png";
		Category category = new Category();
		category.setImage(
			Base64.getEncoder().encodeToString("category-image".getBytes()));
		category.setImageType("image/png");
		when(categoryServiceImpl.getCategoryByImageUrl("category.png"))
			.thenReturn(category);

		// Act
		ResponseEntity<byte[]> response = restTemplate.getForEntity(url,
			byte[].class);

		// Assert
		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getHeaders().getContentType())
			.isEqualTo(MediaType.IMAGE_PNG);
		assertThat(response.getBody()).isEqualTo("category-image".getBytes());
	}

	@Test
	public void testGetImageProductByUrl() {
		// Arrange
		String url = "http://localhost:" + port
			+ "/api/image/product/product.png";
		Product product = new Product();
		product.setImage(
			Base64.getEncoder().encodeToString("product-image".getBytes()));
		product.setImageType("image/png");
		when(productServiceImpl.getProductByImageUrl("product.png"))
			.thenReturn(product);

		// Act
		ResponseEntity<byte[]> response = restTemplate.getForEntity(url,
			byte[].class);

		// Assert
		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getHeaders().getContentType())
			.isEqualTo(MediaType.IMAGE_PNG);
		assertThat(response.getBody()).isEqualTo("product-image".getBytes());
	}

	@Test
	public void testGetBannerByUrl() {
		// Arrange
		String url = "http://localhost:" + port
			+ "/api/image/banner/banner.png";
		Banner banner = new Banner();
		banner.setImage(
			Base64.getEncoder().encodeToString("banner-image".getBytes()));
		banner.setImageType("image/png");
		when(bannerServiceImpl.getBannerByImageUrl("banner.png"))
			.thenReturn(banner);

		// Act
		ResponseEntity<byte[]> response = restTemplate.getForEntity(url,
			byte[].class);

		// Assert
		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getHeaders().getContentType())
			.isEqualTo(MediaType.IMAGE_PNG);
		assertThat(response.getBody()).isEqualTo("banner-image".getBytes());
	}

	@Test
	public void testGetImageOrderByUrl() {
		// Arrange
		int orderId = 1;
		String url = "http://localhost:" + port + "/api/image/order/" + orderId
			+ "/order.png";
		OrderDetail orderDetail = new OrderDetail();
		orderDetail.setImage(
			Base64.getEncoder().encodeToString("order-image".getBytes()));
		orderDetail.setImageType("image/png");
		when(orderDetailServiceImpl.getOrderDetailById(orderId))
			.thenReturn(orderDetail);

		// Act
		ResponseEntity<byte[]> response = restTemplate.getForEntity(url,
			byte[].class);

		// Assert
		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
		assertThat(response.getHeaders().getContentType())
			.isEqualTo(MediaType.IMAGE_PNG);
		assertThat(response.getBody()).isEqualTo("order-image".getBytes());
	}
}
