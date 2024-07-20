package com.funix.foodsaverAPI.controllers;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.funix.foodsaverAPI.services.OrderServiceImpl;

import jakarta.servlet.http.HttpServletRequest;

import com.funix.foodsaverAPI.dto.OrderDTO;
import com.funix.foodsaverAPI.models.Order;
import com.funix.foodsaverAPI.models.OrderDetail;

@ExtendWith(SpringExtension.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class OrderControllerTest {

    @LocalServerPort
    private int port;

    @Autowired
    private TestRestTemplate restTemplate;

    @MockBean
    private OrderServiceImpl orderServiceImpl;

    @Test
    public void testGetOrderByUserId() {
        // Arrange
        String url = "http://localhost:" + port + "/api/order/order-history";
        HttpServletRequest request = mock(HttpServletRequest.class);
        List<OrderDTO> orderHistory = new ArrayList<OrderDTO>();
        when(orderServiceImpl.getOrderByUserId(request)).thenReturn(orderHistory);

        // Act
        ResponseEntity<?> response = restTemplate.exchange(url, HttpMethod.GET, null, Order.class);

        // Assert
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.FORBIDDEN);
        assertThat(response.getBody()).isNull();
    }

    @Test
    public void testGetOrderDetail() {
        // Arrange
        int orderId = 1;
        String url = "http://localhost:" + port + "/api/order/order-detail/" + orderId;
        OrderDTO orderDetail = new OrderDTO();
        when(orderServiceImpl.getOrderById(orderId)).thenReturn(orderDetail);

        // Act
        ResponseEntity<?> response = restTemplate.getForEntity(url, OrderDetail.class);

        // Assert
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.FORBIDDEN);
        assertThat(response.getBody()).isNull();
    }
}
