package com.funix.foodsaverAPI.repositories;

import java.util.List;
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

	@Query(value = "SELECT DISTINCT p.creator_id\r\n"
		+ "FROM foodsaver.cart_item c\r\n"
		+ "INNER JOIN foodsaver.product p\r\n"
		+ "ON c.product_id=p.id\r\n"
		+ "INNER JOIN foodsaver.user u\r\n"
		+ "ON p.creator_id=u.id\r\n"
		+ "WHERE c.cart_id = :cart_id\r\n"
		+ "GROUP BY c.id, c.unit_price, c.unit_quantity, c.cart_id, c.product_id, p.creator_id", nativeQuery = true)
	List<Integer> getDistinctCreatorId(@Param("cart_id")int cartId);
}
