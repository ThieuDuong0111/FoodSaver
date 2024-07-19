package com.funix.foodsaverAPI.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.funix.foodsaverAPI.models.MyUser;

@Repository
public interface IUserRepository extends JpaRepository<MyUser, Integer> {
	@Query(value = "SELECT * FROM User u WHERE u.role_id = :role_id", nativeQuery = true)
	Page<MyUser> findAllByRoleId(@Param("role_id") int role_id,
		Pageable pageable);

	@Query(value = "SELECT * FROM User u WHERE u.role_id = 2 ORDER BY u.id DESC LIMIT 10", nativeQuery = true)
	List<MyUser> get10NewestStore();
	
	@Query(value = "SELECT * FROM User u WHERE u.role_id = 2 ORDER BY u.id", nativeQuery = true)
	List<MyUser> getAllStores();

	Optional<MyUser> findByName(String name);

	Optional<MyUser> findByImageUrl(String imageUrl);

	Optional<MyUser> findByStoreImageUrl(String imageUrl);

	Boolean existsByName(String name);

	Boolean existsByEmail(String email);

	Boolean existsByPhone(String phone);
}
