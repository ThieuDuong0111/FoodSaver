//package com.funix.foodsaverAPI.services;
//
//import java.util.Optional;
//
//import org.modelmapper.ModelMapper;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.data.domain.Page;
//import org.springframework.data.domain.PageRequest;
//import org.springframework.data.domain.Pageable;
//import org.springframework.data.domain.Sort;
//import org.springframework.stereotype.Service;
//
//import com.funix.foodsaveradmin.dto.OrderDTO;
//import com.funix.foodsaveradmin.models.Order;
//import com.funix.foodsaveradmin.repositories.IOrderRepository;
//
//@Service
//public class OrderServiceImpl implements IOrderService {
//
//	@Autowired
//	private IOrderRepository orderRepository;
//	@Autowired
//	private ModelMapper modelMapper;
//
//	@Override
//	public OrderDTO convertToDto(Order Order) {
//		return modelMapper.map(Order, OrderDTO.class);
//	}
//
//	@Override
//	public Order convertToEntity(OrderDTO orderDTO) {
//		return modelMapper.map(orderDTO, Order.class);
//	}
//
//	@Override
//	public OrderDTO getOrderById(int id) {
//		Optional<Order> optionalOrder = orderRepository.findById(id);
//		Order order = null;
//		if (optionalOrder.isPresent()) {
//			order = optionalOrder.get();
//		} else {
//			throw new RuntimeException("Order not found for id : " + id);
//		}
//		return convertToDto(order);
//	}
//
//	@Override
//	public Page<Order> findPaginated(int pageNum, int pageSize,
//		String sortField, String sortDirection) {
//		Sort sort = sortDirection.equalsIgnoreCase(Sort.Direction.ASC.name())
//			? Sort.by(sortField).ascending()
//			: Sort.by(sortField).descending();
//
//		Pageable pageable = PageRequest.of(pageNum - 1, pageSize, sort);
//		return this.orderRepository.findAll(pageable);
//	}
//
//}
