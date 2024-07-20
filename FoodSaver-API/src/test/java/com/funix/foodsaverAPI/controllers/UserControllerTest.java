package com.funix.foodsaverAPI.controllers;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.when;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import com.funix.foodsaverAPI.dto.UserDTO;
import com.funix.foodsaverAPI.models.MyUser;
import com.funix.foodsaverAPI.services.UserServiceImpl;

import jakarta.servlet.http.HttpServletRequest;

@ExtendWith(SpringExtension.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class UserControllerTest {

	@LocalServerPort
	private int port;

	@Autowired
	private TestRestTemplate restTemplate;

	@MockBean
	private UserServiceImpl userServiceImpl;

	@Test
	public void testGetUserInfo() {
		// Arrange
		String url = "http://localhost:" + port + "/api/user/user-info";
		MyUser user = new MyUser(); // Create a mock MyUser object
		UserDTO userDTO = new UserDTO(); // Create a mock UserDTO object
		when(userServiceImpl
			.getUserByToken(Mockito.any(HttpServletRequest.class)))
			.thenReturn(user);
		when(userServiceImpl.convertToDto(user)).thenReturn(userDTO);

		// Act
		ResponseEntity<UserDTO> response = restTemplate.getForEntity(url,
			UserDTO.class);

		// Assert
		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.FORBIDDEN);
	}

	@Test
	public void testUpdateUserInfo() {
		// Arrange
		String url = "http://localhost:" + port + "/api/user/update-info";
		UserDTO userDTO = new UserDTO(); // Create a mock UserDTO object
		UserDTO updatedUserDTO = new UserDTO(); // Create a mock updated UserDTO
												// object
		MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
		body.add("userDTO", userDTO);

		when(userServiceImpl.updateUserInfoMobile(
			Mockito.any(HttpServletRequest.class), Mockito.any(UserDTO.class)))
			.thenReturn(updatedUserDTO);

		// Act
		ResponseEntity<UserDTO> response = restTemplate.exchange(url,
			HttpMethod.PUT, new HttpEntity<>(body, createHeaders()),
			UserDTO.class);

		// Assert
		assertThat(response.getStatusCode()).isEqualTo(HttpStatus.FORBIDDEN);
	}

	private HttpHeaders createHeaders() {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.MULTIPART_FORM_DATA);
		return headers;
	}
}
