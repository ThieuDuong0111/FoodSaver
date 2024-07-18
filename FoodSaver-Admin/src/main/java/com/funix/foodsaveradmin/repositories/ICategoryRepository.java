package com.funix.foodsaveradmin.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.funix.foodsaveradmin.models.Category;

@Repository
public interface ICategoryRepository extends JpaRepository<Category, Integer> {
	Optional<Category> findByName(String name);

}
