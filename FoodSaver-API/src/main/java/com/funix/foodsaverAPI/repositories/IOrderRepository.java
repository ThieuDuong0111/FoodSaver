package com.funix.foodsaverAPI.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.funix.foodsaverAPI.models.Order;

@Repository
public interface IOrderRepository extends JpaRepository<Order, Integer> {
	@Query(value = "SELECT * FROM user_order o WHERE o.user_id = :user_id ORDER BY o.id DESC", nativeQuery = true)
	List<Order> findOrderByUserId(@Param("user_id") int userId);
}
