package com.funix.foodsaveradmin.repositories;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.funix.foodsaveradmin.models.Product;

@Repository
public interface IProductRepository extends JpaRepository<Product, Integer> {
	@Query(value = "SELECT * FROM Product u WHERE u.creator_id = :creator_id", nativeQuery = true)
	Page<Product> findAllByCreatorId(@Param("creator_id") int role_id,
		Pageable pageable);
	
	Optional<Product> findByName(String name);
}
