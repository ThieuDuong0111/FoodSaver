//package com.funix.foodsaverAPI.services;
//
//import com.funix.foodsaverAPI.dto.OrderDTO;
//import com.funix.foodsaverAPI.models.MyUser;
//import com.funix.foodsaverAPI.models.Order;
//import com.funix.foodsaverAPI.repositories.IOrderRepository;
//
//import jakarta.servlet.http.HttpServletRequest;
//
//import org.junit.jupiter.api.Test;
//import org.junit.jupiter.api.extension.ExtendWith;
//import org.mockito.InjectMocks;
//import org.mockito.Mock;
//import org.mockito.Mockito;
//import org.modelmapper.ModelMapper;
//import org.mockito.junit.jupiter.MockitoExtension;
//
//import java.util.Arrays;
//import java.util.Date;
//import java.util.List;
//import java.util.Optional;
//
//import static org.assertj.core.api.Assertions.assertThat;
//import static org.junit.jupiter.api.Assertions.assertThrows;
//import static org.mockito.Mockito.when;
//
//@ExtendWith(MockitoExtension.class)
//public class OrderServiceImplTest {
//
//	@Mock
//	private IOrderRepository orderRepository;
//
//	@Mock
//	private UserServiceImpl userServiceImpl;
//
//	@Mock
//	private ModelMapper modelMapper;
//
//	@InjectMocks
//	private OrderServiceImpl orderService;
//
//	@Test
//	public void testGetOrderById_WhenOrderExists_ShouldReturnOrderDTOWithCreator() {
//		// Mock data
//		int orderId = 1;
//		int creatorId = 1;
//		MyUser creatorUser = new MyUser();
//		creatorUser.setId(creatorId);
//		creatorUser.setName("Test Creator");
//
//		Order order = new Order(creatorUser, new Date(), "ORDER001",
//			true, creatorId, "Test Creator", 1, 1);
//		Optional<Order> optionalOrder = Optional.of(order);
//
//		// Mock repository method
//		when(orderRepository.findById(orderId)).thenReturn(optionalOrder);
//
//		// Mock userServiceImpl method
//		when(userServiceImpl.getUserById(creatorId)).thenReturn(creatorUser);
//
//		// Call service method
//		OrderDTO resultDTO = orderService.getOrderById(orderId);
//
//		// Assertions
//		assertThat(resultDTO).isNotNull();
//		assertThat(resultDTO.getCreator()).isNotNull();
//		assertThat(resultDTO.getCreator().getId())
//			.isEqualTo(creatorUser.getId());
//		assertThat(resultDTO.getCreator().getName())
//			.isEqualTo(creatorUser.getName());
//	}
//
//	@Test
//	public void testGetOrderById_WhenOrderNotFound_ShouldThrowRuntimeException() {
//		// Mock data
//		int orderId = 999;
//
//		// Mock repository method
//		when(orderRepository.findById(orderId)).thenReturn(Optional.empty());
//
//		// Call service method and assert exception
//		assertThrows(RuntimeException.class,
//			() -> orderService.getOrderById(orderId));
//	}
//
//	@Test
//	public void testGetOrderByUserId_ShouldReturnListOfOrderDTOs() {
//		// Mock data
//		HttpServletRequest request = Mockito.mock(HttpServletRequest.class);
//		MyUser user = new MyUser();
//		user.setId(1);
//		user.setName("Test User");
//
//		// Mock userServiceImpl method
//		when(userServiceImpl.getUserByToken(request)).thenReturn(user);
//
//		// Mock repository method
//		Order order1 = new Order(user, new Date(), "ORDER001",
//			true, 1, "Test User", 1, 1);
//		Order order2 = new Order(user, new Date(), "ORDER002",
//			true, 1, "Test User", 1, 1);
//		when(orderRepository.findOrderByUserId(user.getId()))
//			.thenReturn(Arrays.asList(order1, order2));
//
//		// Call service method
//		List<OrderDTO> resultDTOs = orderService.getOrderByUserId(request);
//
//		// Assertions
//		assertThat(resultDTOs).isNotEmpty();
//		assertThat(resultDTOs.size()).isEqualTo(2);
//		assertThat(resultDTOs.get(0).getCreator()).isNotNull();
//		assertThat(resultDTOs.get(0).getCreator().getId())
//			.isEqualTo(user.getId());
//		assertThat(resultDTOs.get(0).getCreator().getName())
//			.isEqualTo(user.getName());
//		assertThat(resultDTOs.get(1).getCreator()).isNotNull();
//		assertThat(resultDTOs.get(1).getCreator().getId())
//			.isEqualTo(user.getId());
//		assertThat(resultDTOs.get(1).getCreator().getName())
//			.isEqualTo(user.getName());
//	}
//}
