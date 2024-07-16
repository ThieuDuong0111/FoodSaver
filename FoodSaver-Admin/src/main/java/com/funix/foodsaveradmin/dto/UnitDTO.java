package com.funix.foodsaveradmin.dto;

import jakarta.validation.constraints.NotEmpty;

public class UnitDTO {
	private int id;

	@NotEmpty(message = "Tên không được bỏ trống.")
	private String name;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
