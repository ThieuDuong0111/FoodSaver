package com.funix.foodsaveradmin.repositories;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.funix.foodsaveradmin.models.FeedBack;

public interface IFeedBackRepository extends JpaRepository<FeedBack, Integer> {
	@Query(value = "SELECT distinct f.id, f.comment, f.rating, f.published_date, f.user_id, f.product_id\r\n"
		+ "FROM foodsaver.feed_back f\r\n"
		+ "INNER JOIN foodsaver.user us\r\n"
		+ "ON f.user_id = us.id\r\n"
		+ "INNER JOIN foodsaver.product p\r\n"
		+ "ON f.product_id = p.id\r\n"
		+ "INNER JOIN foodsaver.user u\r\n"
		+ "ON p.creator_id= :creator_id", nativeQuery = true)
	List<FeedBack> findAllByCreatorId(@Param("creator_id") int creatorId);
}
