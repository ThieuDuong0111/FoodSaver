package com.funix.foodsaveradmin.repositories;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.funix.foodsaveradmin.models.Order;

@Repository
public interface IOrderRepository extends JpaRepository<Order, Integer> {
	Page<Order> findByCreatorId(int creatorId, Pageable pageable);
}
