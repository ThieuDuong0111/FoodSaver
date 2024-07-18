package com.funix.foodsaveradmin.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.funix.foodsaveradmin.models.Unit;

@Repository
public interface IUnitRepository extends JpaRepository<Unit, Integer> {
	Optional<Unit> findByName(String name);
}
