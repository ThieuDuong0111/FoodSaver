package com.funix.foodsaverAPI.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.funix.foodsaverAPI.models.FeedBack;

@Repository
public interface IFeedBackRepository extends JpaRepository<FeedBack, Integer> {
	@Query(value = "SELECT * FROM feed_back f WHERE f.product_id = :product_id ORDER BY f.id DESC", nativeQuery = true)
	List<FeedBack> findByProductId(@Param("product_id") int productId);
}