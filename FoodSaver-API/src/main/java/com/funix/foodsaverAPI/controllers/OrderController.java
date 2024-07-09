package com.funix.foodsaverAPI.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.funix.foodsaverAPI.services.OrderServiceImpl;

import jakarta.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/api/order")
public class OrderController {

	@Autowired
	private OrderServiceImpl orderServiceImpl;

	@GetMapping({ "/order-history" })
	public ResponseEntity<?> getOrderByUserId(HttpServletRequest request) {
		return ResponseEntity.ok(orderServiceImpl.getOrderByUserId(request));
	}

	@GetMapping({ "/order-detail/{id}" })
	public ResponseEntity<?> getOrderDetail(@PathVariable int id) {
		return ResponseEntity.ok(orderServiceImpl.getOrderById(id));
	}

}
