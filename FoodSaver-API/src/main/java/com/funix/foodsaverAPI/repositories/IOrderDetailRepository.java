package com.funix.foodsaverAPI.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.funix.foodsaverAPI.models.OrderDetail;

@Repository
public interface IOrderDetailRepository
	extends JpaRepository<OrderDetail, Integer> {
	Optional<OrderDetail> findByProductImage(String imageUrl);
}
