package com.funix.foodsaverAPI.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.funix.foodsaverAPI.models.Cart;

@Repository
public interface ICartRepository extends JpaRepository<Cart, Integer> {
	@Query(value = "SELECT * FROM Cart c WHERE c.user_id = :user_id AND c.is_done = false", nativeQuery = true)
	Optional<Cart> getItemsByUserId(@Param("user_id") int userId);
}
