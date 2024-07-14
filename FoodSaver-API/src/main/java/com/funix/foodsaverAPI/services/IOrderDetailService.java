package com.funix.foodsaverAPI.services;

import com.funix.foodsaverAPI.models.OrderDetail;

public interface IOrderDetailService {
	OrderDetail getOrderDetailByImageUrl(String url);
	
	OrderDetail getOrderDetailById(int id);
}
