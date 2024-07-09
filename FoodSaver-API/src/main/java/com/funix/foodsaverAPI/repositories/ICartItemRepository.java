package com.funix.foodsaverAPI.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.funix.foodsaverAPI.models.CartItem;

@Repository
public interface ICartItemRepository extends JpaRepository<CartItem, Integer> {
}
