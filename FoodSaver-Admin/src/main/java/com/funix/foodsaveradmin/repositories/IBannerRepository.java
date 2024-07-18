package com.funix.foodsaveradmin.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.funix.foodsaveradmin.models.Banner;

@Repository
public interface IBannerRepository extends JpaRepository<Banner, Integer> {
	Optional<Banner> findByName(String name);
}
