package com.funix.foodsaverAPI.services;

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
import com.funix.foodsaverAPI.models.Product;
import com.funix.foodsaverAPI.repositories.ICartItemRepository;
import com.funix.foodsaverAPI.repositories.ICartRepository;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class CartServiceImpl implements ICartService {

	@Autowired
	private ICartRepository cartRepository;

	@Autowired
	private ICartItemRepository cartItemRepository;

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
		return convertToDto(cartGet.get());
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
					cartItems.get(i).getUnitQuantity() * productServiceImpl
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
				cartItemProductDTO.getQuantity() * product.getPrice());

			cart.get().getCartItems().add(cartItem);

			// Save CartItem
			cartItemRepository.save(cartItem);
		}

		// Return Cart
		Optional<Cart> cartGet = cartRepository.getItemsByUserId(user.getId());
		return convertToDto(cartGet.get());

	}

	@Override
	public CartDTO deleteItem(HttpServletRequest request,
		CartItemDTO cartItemDTO) {
		cartItemRepository.deleteById(cartItemDTO.getId());
		MyUser user = userService.getUserByToken(request);
		Optional<Cart> cart = cartRepository.getItemsByUserId(user.getId());
		return convertToDto(cart.get());
	}

	@Transactional
	@Override
	public CartDTO checkout(HttpServletRequest request, CartDTO cartDTO) {
		MyUser user = userService.getUserByToken(request);
		Optional<Cart> cart = cartRepository.getItemsByUserId(user.getId());
		
		//Check quantity
		
		
		Optional<Cart> cartGet = cartRepository.getItemsByUserId(user.getId());
		return convertToDto(cartGet.get());

	}
}
