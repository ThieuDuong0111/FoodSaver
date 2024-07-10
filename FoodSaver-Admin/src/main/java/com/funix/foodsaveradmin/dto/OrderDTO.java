package com.funix.foodsaveradmin.dto;

import java.util.Date;
import java.util.List;

public class OrderDTO {
	private int id;

	private List<OrderDetailDTO> orderDetails;

	private UserDTO userOrders;

	private UserDTO creator;

	private Date publishedDate;

	private String orderCode;

	private double totalAmount;

	private Boolean isPaid;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getPublishedDate() {
		return publishedDate;
	}

	public void setPublishedDate(Date publishedDate) {
		this.publishedDate = publishedDate;
	}

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public List<OrderDetailDTO> getOrderDetails() {
		return orderDetails;
	}

	public void setOrderDetails(List<OrderDetailDTO> orderDetails) {
		this.orderDetails = orderDetails;
	}

	public UserDTO getUserOrders() {
		return userOrders;
	}

	public void setUserOrders(UserDTO userOrders) {
		this.userOrders = userOrders;
	}

	public UserDTO getCreator() {
		return creator;
	}

	public void setCreator(UserDTO creator) {
		this.creator = creator;
	}

	public Boolean getIsPaid() {
		return isPaid;
	}

	public void setIsPaid(Boolean isPaid) {
		this.isPaid = isPaid;
	}

}
