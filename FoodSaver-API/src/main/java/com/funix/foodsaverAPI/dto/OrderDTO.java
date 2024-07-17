package com.funix.foodsaverAPI.dto;

import java.util.Date;
import java.util.List;

public class OrderDTO {
	private int id;

	private List<OrderDetailDTO> orderDetails;

	private Date publishedDate;

	private String orderCode;

	private double totalAmount;

	private Boolean isPaid;

	private String creatorName;

	private UserDTO creator;

	private int statusType;

	private String statusTypeParse;

	private int paymentType;

	private String paymentTypeParse;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public List<OrderDetailDTO> getOrderDetails() {
		return orderDetails;
	}

	public void setOrderDetails(List<OrderDetailDTO> orderDetails) {
		this.orderDetails = orderDetails;
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

	public Boolean getIsPaid() {
		return isPaid;
	}

	public void setIsPaid(Boolean isPaid) {
		this.isPaid = isPaid;
	}

	public String getCreatorName() {
		return creatorName;
	}

	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}

	public UserDTO getCreator() {
		return creator;
	}

	public void setCreator(UserDTO creator) {
		this.creator = creator;
	}

	public int getStatusType() {
		return statusType;
	}

	public void setStatusType(int statusType) {
		this.statusType = statusType;
	}

	public int getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(int paymentType) {
		this.paymentType = paymentType;
	}

	public String getStatusTypeParse() {
		return statusTypeParse;
	}

	public void setStatusTypeParse(String statusTypeParse) {
		this.statusTypeParse = statusTypeParse;
	}

	public String getPaymentTypeParse() {
		return paymentTypeParse;
	}

	public void setPaymentTypeParse(String paymentTypeParse) {
		this.paymentTypeParse = paymentTypeParse;
	}
}
