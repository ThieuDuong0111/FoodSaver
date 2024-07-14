package com.funix.foodsaverAPI.services;

import com.funix.foodsaverAPI.models.OrderDetail;

public interface IOrderDetailService {
	OrderDetail getOrderByImageUrl(String url);
}
