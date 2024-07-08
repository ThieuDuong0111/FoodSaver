package com.funix.foodsaverAPI.repositories;

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

	Optional<MyUser> findByName(String name);

	Optional<MyUser> findByImageUrl(String imageUrl);

	Boolean existsByName(String name);

	Boolean existsByEmail(String email);

	Boolean existsByPhone(String phone);
}
