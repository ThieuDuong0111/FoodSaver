package com.funix.foodsaverAPI.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.funix.foodsaverAPI.models.Order;

@Repository
public interface IOrderRepository extends JpaRepository<Order, Integer> {
}
