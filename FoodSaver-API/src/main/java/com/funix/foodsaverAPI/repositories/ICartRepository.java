package com.funix.foodsaverAPI.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.funix.foodsaverAPI.models.Cart;

@Repository
public interface ICartRepository extends JpaRepository<Cart, Integer> {
}
