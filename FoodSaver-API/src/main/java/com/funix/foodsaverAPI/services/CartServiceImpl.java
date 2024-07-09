package com.funix.foodsaverAPI.services;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.funix.foodsaverAPI.dto.CartDTO;
import com.funix.foodsaverAPI.dto.CartItemDTO;
import com.funix.foodsaverAPI.dto.CartItemProductDTO;
import com.funix.foodsaverAPI.models.Cart;
import com.funix.foodsaverAPI.models.CartItem;
import com.funix.foodsaverAPI.models.MyUser;
import com.funix.foodsaverAPI.models.Order;
import com.funix.foodsaverAPI.models.OrderDetail;
import com.funix.foodsaverAPI.models.Product;
import com.funix.foodsaverAPI.repositories.ICartItemRepository;
import com.funix.foodsaverAPI.repositories.ICartRepository;
import com.funix.foodsaverAPI.repositories.IOrderDetailRepository;
import com.funix.foodsaverAPI.repositories.IOrderRepository;
import com.funix.foodsaverAPI.utils.ParseUtils;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class CartServiceImpl implements ICartService {

	@Autowired
	private ICartRepository cartRepository;

	@Autowired
	private ICartItemRepository cartItemRepository;

	@Autowired
	private IOrderRepository orderRepository;

	@Autowired
	private IOrderDetailRepository orderDetailRepository;

	@Autowired
	private ProductServiceImpl productServiceImpl;

	@Autowired
	private IUserService userService;

	@Autowired
	private ModelMapper modelMapper;

	@Override
	public CartDTO convertToDto(Cart cart) {
		return modelMapper.map(cart, CartDTO.class);
	}

	@Override
	public OrderDetail convertToOrderDetail(CartItem cartItem) {
		return modelMapper.map(cartItem, OrderDetail.class);
	}

	@Override
	public CartDTO getItems(HttpServletRequest request) {
		MyUser user = userService.getUserByToken(request);
		Optional<Cart> cart = cartRepository.getItemsByUserId(user.getId());
		// If Cart not exist, create one
		if (!cart.isPresent()) {
			cartRepository
				.save(new Cart(new ArrayList<CartItem>(), user, new Date(),
					false));
		}
		Optional<Cart> cartGet = cartRepository.getItemsByUserId(user.getId());
		CartDTO cartDTO = convertToDto(cartGet.get());
		cartDTO.setTotalAmount(calculateTotalAmountOfCart(cartDTO));
		cartDTO.getCartItems().stream().map(cartItemDTO -> productServiceImpl
			.convertFromCartItemToProductDTO(cartItemDTO)).toList();
		return cartDTO;
	}

	@Transactional
	@Override
	public CartDTO updateItem(HttpServletRequest request,
		CartItemProductDTO cartItemProductDTO) {
		MyUser user = userService.getUserByToken(request);
		Optional<Cart> cart = cartRepository.getItemsByUserId(user.getId());

		List<CartItem> cartItems = cart.get().getCartItems();
		Boolean isItemExist = false;

		// Check Item Exist
		for (int i = 0; i < cartItems.size(); i++) {

			// Check Product is exist in list cart items
			if (cartItems.get(i).getCartProduct().getId() == cartItemProductDTO
				.getId()) {
				isItemExist = true;

				int currentQuantity = cartItems.get(i).getUnitQuantity();

				// Stop if quantity <= 0
				if ((cartItems.get(i).getUnitQuantity()
					+ cartItemProductDTO.getQuantity()) <= 0) {
					break;
				}

				// Update Unit Quantity
				cartItems.get(i).setUnitQuantity(
					currentQuantity + cartItemProductDTO.getQuantity());
				// Update Unit Price
				cartItems.get(i).setUnitPrice(
					productServiceImpl
						.getProductById(cartItemProductDTO.getId()).getPrice());

				// Save CartItem
				cartItemRepository.save(cartItems.get(i));
			}
		}

		// If Item Is Not Exist
		if (!isItemExist) {
			Product product = productServiceImpl
				.getProductById(cartItemProductDTO.getId());
			CartItem cartItem = new CartItem(cart.get(), product,
				cartItemProductDTO.getQuantity(),
				product.getPrice());

			cart.get().getCartItems().add(cartItem);

			// Save CartItem
			cartItemRepository.save(cartItem);
		}

		// Return Cart
		Optional<Cart> cartGet = cartRepository.getItemsByUserId(user.getId());
		CartDTO cartDTO = convertToDto(cartGet.get());
		cartDTO.setTotalAmount(calculateTotalAmountOfCart(cartDTO));
		cartDTO.getCartItems().stream().map(cartItemDTO -> productServiceImpl
			.convertFromCartItemToProductDTO(cartItemDTO)).toList();
		return cartDTO;

	}

	@Override
	public CartDTO deleteItem(HttpServletRequest request,
		CartItemDTO cartItemDTO) {
		MyUser user = userService.getUserByToken(request);
		Optional<Cart> cart = cartRepository.getItemsByUserId(user.getId());

		// Delete Cart Item
		cartItemRepository.deleteById(cartItemDTO.getId());

		CartDTO cartDTO = convertToDto(cart.get());
		cartDTO.setTotalAmount(calculateTotalAmountOfCart(cartDTO));
		cartDTO.getCartItems().stream().map(cartItemDto -> productServiceImpl
			.convertFromCartItemToProductDTO(cartItemDto)).toList();
		return cartDTO;
	}

	@Transactional
	@Override
	public void checkout(HttpServletRequest request)
		throws IllegalArgumentException, ParseException {
		MyUser user = userService.getUserByToken(request);
		Cart cart = cartRepository.getItemsByUserId(user.getId()).get();
		List<CartItem> cartItems = cart.getCartItems();

		if (cartItems.size() > 0) {
			// Check quantity
			int currentProductQuantity = 0;
			for (int i = 0; i < cartItems.size(); i++) {
				currentProductQuantity = productServiceImpl
					.getProductById(cartItems.get(i).getCartProduct().getId())
					.getQuantity();
				if (cartItems.get(i)
					.getUnitQuantity() > currentProductQuantity) {
					throw new IllegalArgumentException(
						"Product quantity is not enough.");
				}
			}

			// Update Product Quantity
			for (int i = 0; i < cartItems.size(); i++) {
				Product product = productServiceImpl
					.getProductById(cartItems.get(i).getCartProduct().getId());
				product.setQuantity(product.getQuantity() - cartItems.get(i)
					.getUnitQuantity());
			}

			// Get Distinct Creator Id
			List<Integer> creatorIds = cartRepository
				.getDistinctCreatorId(cart.getId());

			// Seperate Order
			for (int i = 0; i < creatorIds.size(); i++) {

				// Create Order
				Order order = new Order(cart.getUserCarts(), new Date(),
					ParseUtils.generateOrderCode(), false, creatorIds.get(i));
				List<OrderDetail> orderDetails = new ArrayList<OrderDetail>();
				orderRepository.save(order);

				for (int j = 0; j < cartItems.size(); j++) {
					if (creatorIds.get(i) == cartItems.get(j).getCartProduct()
						.getCreator().getId()) {
						orderDetails.add(new OrderDetail(order,
							cartItems.get(j).getCartProduct().getId(),
							cartItems.get(j).getCartProduct().getName(),
							cartItems.get(j).getCartProduct()
								.getImageUrl() != null
									? "http://localhost:8080/api/image/product/"
										+ cartItems.get(j).getCartProduct()
											.getImageUrl()
									: cartItems.get(j).getCartProduct()
										.getImageUrl(),
							cartItems.get(j).getUnitQuantity(),
							cartItems.get(j).getUnitPrice()));
					}
				}
				order.setOrderDetails(orderDetails);
				order.setTotalAmount(calculateTotalAmountOfOrder(order));
				orderDetailRepository.saveAll(order.getOrderDetails());
			}

			// Update Cart Done
			cart.setIsDone(true);

			cartRepository.save(cart);
		}

	}

	@Override
	public BigDecimal calculateTotalAmountOfCart(CartDTO cartDTO) {
		double totalAmount = 0.0;

		if (cartDTO.getCartItems().size() == 0) {
			return new BigDecimal(totalAmount);
		}
		for (int i = 0; i < cartDTO.getCartItems().size(); i++) {
			totalAmount = totalAmount
				+ cartDTO.getCartItems().get(i).getUnitPrice()
					* cartDTO.getCartItems().get(i).getUnitQuantity();

		}
		return new BigDecimal(totalAmount);
	}

	@Override
	public BigDecimal calculateTotalAmountOfOrder(Order order) {
		double totalAmount = 0.0;
		if (order.getOrderDetails().size() == 0) {
			return new BigDecimal(totalAmount);
		}
		for (int i = 0; i < order.getOrderDetails().size(); i++) {
			totalAmount = totalAmount
				+ order.getOrderDetails().get(i).getUnitPrice()
					* order.getOrderDetails().get(i).getUnitQuantity();

		}
		return new BigDecimal(totalAmount);
	}
}
