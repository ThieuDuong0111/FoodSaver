package com.funix.foodsaveradmin.services;

import org.springframework.data.domain.Page;

import com.funix.foodsaveradmin.dto.OrderDTO;
import com.funix.foodsaveradmin.models.Order;

public interface IOrderService {

	OrderDTO convertToDto(Order order);

	Order convertToEntity(OrderDTO orderDTO);

	OrderDTO getOrderById(int id);

	Page<Order> findPaginated(int pageNum, int pageSize,
		String sortField,
		String sortDirection);
}
