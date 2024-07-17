package com.funix.foodsaveradmin.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.funix.foodsaveradmin.dto.UserDTO;
import com.funix.foodsaveradmin.models.Order;
import com.funix.foodsaveradmin.services.OrderServiceImpl;
import com.funix.foodsaveradmin.services.UserServiceImpl;

@Controller
@RequestMapping({ "/food_creator/orders" })
public class OrderControllerFoodCreator {
	private static String redirectOrder = "redirect:/food_creator/orders/page/1?sortField=id&sortDir=desc";
	private static String redirectOrderDetail = "redirect:/food_creator/orders/detail/";

	@Autowired
	private OrderServiceImpl orderServiceImpl;

	@Autowired
	private UserServiceImpl userServiceImpl;

	@GetMapping({ "", "/" })
	public String viewOrderPage(Model model) {
		return redirectOrder;
	}

	@GetMapping("/detail/{id}")
	public String showFormForUpdate(@PathVariable(value = "id") int id,
		Model model) {
		Order order = orderServiceImpl
			.convertToEntity(orderServiceImpl.getOrderById(id));
		UserDTO userDTO = userServiceImpl
			.getUserById(order.getUserOrders().getId());
		model.addAttribute("userDTO", userDTO);
		model.addAttribute("order", order);
		return "order_detail_food_creator";
	}

	@GetMapping("/confirm/{id}")
	public String cofirmOrder(@PathVariable(value = "id") int id) {
		try {
			orderServiceImpl.confirmOrderById(id);
		} catch (Exception e) {
			return redirectOrderDetail + id;
		}
		return redirectOrderDetail + id;
	}

	@GetMapping("/approve/{id}")
	public String approveOrder(@PathVariable(value = "id") int id) {
		try {
			orderServiceImpl.approveOrderById(id);
		} catch (Exception e) {
			return redirectOrderDetail + id;
		}
		return redirectOrderDetail + id;
	}

	@GetMapping("/cancel/{id}")
	public String cancelOrder(@PathVariable(value = "id") int id) {
		try {
			orderServiceImpl.cancelOrderById(id);
		} catch (Exception e) {
			return redirectOrderDetail + id;
		}
		return redirectOrderDetail + id;
	}

	@GetMapping("/page/{pageNo}")
	public String findPaginated(@PathVariable(value = "pageNo") int pageNo,
		@RequestParam(value = "sortField", required = true) String sortField,
		@RequestParam(value = "sortDir", required = true) String sortDir,

		Model model) {
		int pageSize = 12;

		Page<Order> page = orderServiceImpl.findPaginatedByCreatorId(pageNo,
			pageSize,
			sortField, sortDir, userServiceImpl.getLoggedInUserInfo().getId());
		List<Order> listorders = page.getContent();

		model.addAttribute("currentPage", pageNo);
		model.addAttribute("totalPages", page.getTotalPages());
		model.addAttribute("totalItems", page.getTotalElements());

		model.addAttribute("sortField", sortField);
		model.addAttribute("sortDir", sortDir);
		model.addAttribute("reverseSortDir",
			sortDir.equals("asc") ? "desc" : "asc");
		model.addAttribute("listorders", listorders);
		return "list_orders_food_creator";
	}
}
