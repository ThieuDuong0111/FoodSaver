package com.funix.foodsaverAPI.controllers;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.funix.foodsaverAPI.dto.HomeDTO;

@ExtendWith(SpringExtension.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class HomeControllerTest {

    @LocalServerPort
    private int port;

    @Autowired
    private TestRestTemplate restTemplate;

    @Test
    public void testGetHome() {
        // Arrange
        String url = "http://localhost:" + port + "/api/home";
        // Act
        ResponseEntity<HomeDTO> response = restTemplate.getForEntity(url, HomeDTO.class);

        // Assert
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
        HomeDTO homeDTO = response.getBody();
        assertThat(homeDTO).isNotNull();
        assertThat(homeDTO.getBanners()).isNotNull();
        assertThat(homeDTO.getCategories()).isNotNull();
        assertThat(homeDTO.getStores()).isNotNull();
        assertThat(homeDTO.getProducts()).isNotNull();
    }
}
