package com.funix.foodsaveradmin.services;

import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.funix.foodsaveradmin.dto.OrderDTO;
import com.funix.foodsaveradmin.models.Order;
import com.funix.foodsaveradmin.models.OrderDetail;
import com.funix.foodsaveradmin.models.Product;
import com.funix.foodsaveradmin.repositories.IOrderRepository;
import com.funix.foodsaveradmin.repositories.IProductRepository;

@Service
public class OrderServiceImpl implements IOrderService {

	@Autowired
	private IOrderRepository orderRepository;

	@Autowired
	private IProductRepository productRepository;

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
		if (optionalOrder.isPresent()) {
			order = optionalOrder.get();
		} else {
			throw new RuntimeException("Order not found for id : " + id);
		}
		return convertToDto(order);
	}

	@Override
	public Page<Order> findPaginated(int pageNum, int pageSize,
		String sortField, String sortDirection) {
		Sort sort = sortDirection.equalsIgnoreCase(Sort.Direction.ASC.name())
			? Sort.by(sortField).ascending()
			: Sort.by(sortField).descending();

		Pageable pageable = PageRequest.of(pageNum - 1, pageSize, sort);
		return this.orderRepository.findAll(pageable);
	}

	@Override
	public Page<Order> findPaginatedByCreatorId(int pageNum, int pageSize,
		String sortField, String sortDirection, int creatorId) {
		Sort sort = sortDirection.equalsIgnoreCase(Sort.Direction.ASC.name())
			? Sort.by(sortField).ascending()
			: Sort.by(sortField).descending();

		Pageable pageable = PageRequest.of(pageNum - 1, pageSize, sort);
		return this.orderRepository.findByCreatorId(creatorId, pageable);
	}

	@Override
	public void confirmOrderById(int id) {
		Optional<Order> optionalOrder = orderRepository.findById(id);
		Order order = null;
		if (optionalOrder.isPresent()) {
			order = optionalOrder.get();
		} else {
			throw new RuntimeException("Order not found for id : " + id);
		}
		order.setStatusType(1);
		orderRepository.save(order);
	}

	@Override
	public void approveOrderById(int id) {
		Optional<Order> optionalOrder = orderRepository.findById(id);
		Order order = null;
		if (optionalOrder.isPresent()) {
			order = optionalOrder.get();
		} else {
			throw new RuntimeException("Order not found for id : " + id);
		}
		order.setIsPaid(true);
		order.setStatusType(3);
		orderRepository.save(order);
	}

	@Override
	public void cancelOrderById(int id) {
		Optional<Order> optionalOrder = orderRepository.findById(id);
		Order order = null;
		if (optionalOrder.isPresent()) {
			order = optionalOrder.get();
			// Update Product Quantity
			List<OrderDetail> orderDetails = order.getOrderDetails();
			for (int i = 0; i < orderDetails.size(); i++) {
				Product product = productRepository
					.findById(orderDetails.get(i).getProductId()).get();
				product.setQuantity(product.getQuantity()
					+ orderDetails.get(i).getUnitQuantity());
			}
		} else {
			throw new RuntimeException("Order not found for id : " + id);
		}
		order.setStatusType(2);
		orderRepository.save(order);
	}
}
