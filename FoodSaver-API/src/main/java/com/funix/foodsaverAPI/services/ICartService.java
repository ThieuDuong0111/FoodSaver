package com.funix.foodsaverAPI.services;

import com.funix.foodsaverAPI.dto.CartDTO;
import com.funix.foodsaverAPI.dto.CartItemDTO;
import com.funix.foodsaverAPI.dto.CartItemProductDTO;
import com.funix.foodsaverAPI.models.Cart;
import jakarta.servlet.http.HttpServletRequest;

public interface ICartService {
	CartDTO convertToDto(Cart cart);

	CartDTO getItems(HttpServletRequest request);

	CartDTO updateItem(HttpServletRequest request,
		CartItemProductDTO cartItemProductDTO);

	CartDTO deleteItem(HttpServletRequest request,
		CartItemDTO cartItemDTO);

	CartDTO checkout(HttpServletRequest request,
		CartDTO cartDTO);
}
