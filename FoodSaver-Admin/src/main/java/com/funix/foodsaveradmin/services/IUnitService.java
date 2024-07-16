package com.funix.foodsaveradmin.services;

import java.util.List;

import org.springframework.data.domain.Page;

import com.funix.foodsaveradmin.dto.UnitDTO;
import com.funix.foodsaveradmin.models.Unit;

public interface IUnitService {

	UnitDTO convertToDto(Unit Unit);

	Unit convertToEntity(UnitDTO UnitDTO);

	List<Unit> getAllUnits();

	void saveUnit(UnitDTO UnitDTO);

	UnitDTO getUnitById(int id);

	void deleteUnitById(int id);

	Page<Unit> findPaginated(int pageNum, int pageSize,
		String sortField,
		String sortDirection);
}
