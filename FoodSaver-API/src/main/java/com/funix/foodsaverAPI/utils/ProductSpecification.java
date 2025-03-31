package com.funix.foodsaverAPI.utils;

import org.springframework.data.jpa.domain.Specification;

import com.funix.foodsaverAPI.models.Category;
import com.funix.foodsaverAPI.models.MyUser;
import com.funix.foodsaverAPI.models.Product;

import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.JoinType;

public class ProductSpecification {
	public static Specification<Product> hasNameContaining(String keyword) {
		return (root, query, criteriaBuilder) -> criteriaBuilder.like(criteriaBuilder.lower(root.get("name")),
				"%" + keyword.toLowerCase() + "%");
	}

	public static Specification<Product> hasCategoryNameContaining(String keyword) {
		return (root, query, criteriaBuilder) -> {
			Join<Product, Category> categoryJoin = root.join("category", JoinType.LEFT);
			return criteriaBuilder.like(criteriaBuilder.lower(categoryJoin.get("name")),
					"%" + keyword.toLowerCase() + "%");
		};
	}

	public static Specification<Product> hasCreatorNameContaining(String keyword) {
		return (root, query, criteriaBuilder) -> {
			Join<Product, MyUser> creatorJoin = root.join("creator", JoinType.LEFT);
			return criteriaBuilder.like(criteriaBuilder.lower(creatorJoin.get("name")),
					"%" + keyword.toLowerCase() + "%");
		};
	}

	public static Specification<Product> searchByKeyword(String keyword) {
	    return Specification.where(hasNameContaining(keyword))
                .or(hasCategoryNameContaining(keyword))
                .or(hasCreatorNameContaining(keyword));
	}
}
