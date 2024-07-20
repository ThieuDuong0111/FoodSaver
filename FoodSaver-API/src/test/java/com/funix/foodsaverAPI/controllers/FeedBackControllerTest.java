package com.funix.foodsaverAPI.controllers;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.when;

import java.util.Collections;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.funix.foodsaverAPI.dto.AddFeedBackDTO;
import com.funix.foodsaverAPI.services.FeedBackServiceImpl;

@ExtendWith(SpringExtension.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class FeedBackControllerTest {

    @LocalServerPort
    private int port;

    @Autowired
    private TestRestTemplate restTemplate;

    @MockBean
    private FeedBackServiceImpl feedBackServiceImpl;

    @Test
    public void testAddFeedBack() {
        // Arrange
        String url = "http://localhost:" + port + "/api/feedback/add-feedback";
        AddFeedBackDTO addFeedBackDTO = new AddFeedBackDTO();
        // Setup any required fields in addFeedBackDTO

        // Act
        HttpEntity<AddFeedBackDTO> request = new HttpEntity<>(addFeedBackDTO);
        ResponseEntity<?> response = restTemplate.postForEntity(url, request, AddFeedBackDTO.class);

        // Assert
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.FORBIDDEN);
        assertThat(response.getBody()).isNull();;
    }

    @Test
    public void testGetFeedBacksByProductId() {
        // Arrange
        int productId = 1;
        String url = "http://localhost:" + port + "/api/feedback/get-feedbacks/" + productId;
        // Mock the service to return some feedbacks
        when(feedBackServiceImpl.getFeedBacksByProductId(productId)).thenReturn(Collections.emptyList());

        // Act
        ResponseEntity<?> response = restTemplate.getForEntity(url, Object.class);

        // Assert
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(response.getBody()).isNotInstanceOf(Collections.emptyList().getClass());
    }
}
