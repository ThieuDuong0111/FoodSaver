package com.funix.foodsaverAPI.services;

import java.util.List;

import com.funix.foodsaverAPI.dto.OrderDTO;
import com.funix.foodsaverAPI.models.Order;

import jakarta.servlet.http.HttpServletRequest;

public interface IOrderService {

	OrderDTO convertToDto(Order order);

	Order convertToEntity(OrderDTO orderDTO);

	List<OrderDTO> getOrderByUserId(HttpServletRequest request);

	OrderDTO getOrderById(int id);
}
