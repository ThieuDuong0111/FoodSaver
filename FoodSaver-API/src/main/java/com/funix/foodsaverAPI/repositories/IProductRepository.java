package com.funix.foodsaverAPI.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.funix.foodsaverAPI.models.Product;

@Repository
public interface IProductRepository extends JpaRepository<Product, Integer> {

	@Query(value = "SELECT * FROM Product p ORDER BY p.id DESC LIMIT 20", nativeQuery = true)
	List<Product> getTop20Products();
	
	@Query(value = "SELECT * FROM Product p ORDER BY p.sold_count DESC LIMIT 5", nativeQuery = true)
	List<Product> getTop5MostPurchaseProducts();

	Optional<Product> findByImageUrl(String imageUrl);

	List<Product> findByCategoryId(int categoryId);
	
	List<Product> findByCreatorId(int creatorId);

	@Query(value = "SELECT * FROM Product p WHERE p.name LIKE " + "%:name%", nativeQuery = true)
	List<Product> searchByName(@Param("name") String name);

}
