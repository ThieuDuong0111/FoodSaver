package com.funix.foodsaveradmin.dto;

import java.util.Date;
import java.util.List;

import com.funix.foodsaveradmin.models.OrderDetail;
import com.funix.foodsaveradmin.models.MyUser;

public class OrderDTO {
	private int id;

	private List<OrderDetail> orderDetails;

	private MyUser userOrders;

	private Date publishedDate;

	private String orderCode;

	private double totalAmount;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public List<OrderDetail> getOrderDetails() {
		return orderDetails;
	}

	public void setOrderDetails(List<OrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}

	public MyUser getUserOrders() {
		return userOrders;
	}

	public void setUserOrders(MyUser userOrders) {
		this.userOrders = userOrders;
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
}
