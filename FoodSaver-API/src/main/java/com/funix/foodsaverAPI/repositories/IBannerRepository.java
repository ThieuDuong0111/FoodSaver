package com.funix.foodsaverAPI.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.funix.foodsaverAPI.models.Banner;

@Repository
public interface IBannerRepository extends JpaRepository<Banner, Integer> {
	Optional<Banner> findByImageUrl(String imageUrl);
}
