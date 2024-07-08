package com.funix.foodsaveradmin.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.funix.foodsaveradmin.models.Category;

@Repository
public interface ICategoryRepository extends JpaRepository<Category, Integer> {
}
