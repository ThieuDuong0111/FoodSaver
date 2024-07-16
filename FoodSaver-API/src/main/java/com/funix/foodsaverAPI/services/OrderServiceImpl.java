package com.funix.foodsaverAPI.services;

import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.funix.foodsaverAPI.dto.OrderDTO;
import com.funix.foodsaverAPI.models.MyUser;
import com.funix.foodsaverAPI.models.Order;
import com.funix.foodsaverAPI.repositories.IOrderRepository;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class OrderServiceImpl implements IOrderService {

	@Autowired
	private IOrderRepository orderRepository;

	@Autowired
	private UserServiceImpl userServiceImpl;

	@Autowired
	private ModelMapper modelMapper;

	@Override
	public OrderDTO convertToDto(Order Order) {
		return modelMapper.map(Order, OrderDTO.class);
	}

	@Override
	public Order convertToEntity(OrderDTO orderDTO) {
		return modelMapper.map(orderDTO, Order.class);
	}

	@Override
	public OrderDTO getOrderById(int id) {
		Optional<Order> optionalOrder = orderRepository.findById(id);
		Order order = null;
		MyUser creator = null;
		if (optionalOrder.isPresent()) {
			order = optionalOrder.get();
			creator = userServiceImpl.getUserById(order.getCreatorId());
		} else {
			throw new RuntimeException("Order not found for id : " + id);
		}
		OrderDTO orderDTO = convertToDto(order);
		orderDTO.setCreator(userServiceImpl.convertToDto(creator));
		return orderDTO;
	}

	@Override
	public List<OrderDTO> getOrderByUserId(HttpServletRequest request) {
		MyUser user = userServiceImpl.getUserByToken(request);
		return orderRepository.findOrderByUserId(user.getId()).stream()
			.map(this::convertToDto).toList();
	}
}
