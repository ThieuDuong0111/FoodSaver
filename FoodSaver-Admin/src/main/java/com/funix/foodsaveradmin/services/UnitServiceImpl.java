package com.funix.foodsaveradmin.services;

import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.funix.foodsaveradmin.dto.UnitDTO;
import com.funix.foodsaveradmin.models.Unit;
import com.funix.foodsaveradmin.repositories.IUnitRepository;

@Service
public class UnitServiceImpl implements IUnitService {
	@Autowired
	private IUnitRepository UnitRepository;
	@Autowired
	private ModelMapper modelMapper;

	@Override
	public List<Unit> getAllUnits() {
		return UnitRepository.findAll();
	}

	@Override
	public UnitDTO convertToDto(Unit Unit) {
		return modelMapper.map(Unit, UnitDTO.class);
	}

	@Override
	public Unit convertToEntity(UnitDTO UnitDTO) {
		return modelMapper.map(UnitDTO, Unit.class);
	}

	@Override
	public void saveUnit(UnitDTO UnitDTO) {
		this.UnitRepository.save(convertToEntity(UnitDTO));
	}

	@Override
	public UnitDTO getUnitById(int id) {
		Optional<Unit> optionalUnit = UnitRepository.findById(id);
		Unit Unit = null;
		if (optionalUnit.isPresent()) {
			Unit = optionalUnit.get();
		} else {
			throw new RuntimeException("Unit not found for id : " + id);
		}
		return convertToDto(Unit);
	}

	@Override
	public void deleteUnitById(int id) {
		this.UnitRepository.deleteById(id);

	}

	@Override
	public Page<Unit> findPaginated(int pageNum, int pageSize,
		String sortField,
		String sortDirection) {
		Sort sort = sortDirection.equalsIgnoreCase(Sort.Direction.ASC.name())
			? Sort.by(sortField).ascending()
			: Sort.by(sortField).descending();

		Pageable pageable = PageRequest.of(pageNum - 1, pageSize, sort);
		return this.UnitRepository.findAll(pageable);
	}
}
