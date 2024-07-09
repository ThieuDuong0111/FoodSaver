package com.funix.foodsaverAPI.services;

import java.math.BigDecimal;
import java.text.ParseException;

import com.funix.foodsaverAPI.dto.CartDTO;
import com.funix.foodsaverAPI.dto.CartItemDTO;
import com.funix.foodsaverAPI.dto.CartItemProductDTO;
import com.funix.foodsaverAPI.models.Cart;
import com.funix.foodsaverAPI.models.CartItem;
import com.funix.foodsaverAPI.models.Order;
import com.funix.foodsaverAPI.models.OrderDetail;

import jakarta.servlet.http.HttpServletRequest;

public interface ICartService {
	
	CartDTO convertToDto(Cart cart);

	OrderDetail convertToOrderDetail(CartItem cartItem);

	CartDTO getItems(HttpServletRequest request);

	CartDTO updateItem(HttpServletRequest request,
		CartItemProductDTO cartItemProductDTO);

	CartDTO deleteItem(HttpServletRequest request,
		CartItemDTO cartItemDTO);

	void checkout(HttpServletRequest request)
		throws IllegalArgumentException, ParseException;

	BigDecimal calculateTotalAmountOfCart(CartDTO cartDTO);

	BigDecimal calculateTotalAmountOfOrder(Order order);
}
