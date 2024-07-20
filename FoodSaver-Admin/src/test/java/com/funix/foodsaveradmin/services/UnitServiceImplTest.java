package com.funix.foodsaveradmin.services;

import com.funix.foodsaveradmin.dto.UnitDTO;
import com.funix.foodsaveradmin.models.Unit;
import com.funix.foodsaveradmin.repositories.IUnitRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertAll;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class UnitServiceImplTest {

	@Mock
	private IUnitRepository unitRepository;

	@Mock
	private ModelMapper modelMapper;

	@InjectMocks
	private UnitServiceImpl unitService;

	@Test
	public void UnitService_SaveUnit_ReturnUnit() {
		// Mocking input DTO
		UnitDTO unitDTO = new UnitDTO();
		unitDTO.setName("Unit Test");

		Unit convertedUnit = new Unit();

		when(modelMapper.map(unitDTO, Unit.class)).thenReturn(convertedUnit);

		unitService.saveUnit(unitDTO);

		verify(unitRepository, times(1)).save(convertedUnit);

	}

	@Test
	public void UnitService_WhenGetAll_shouldReturnList() {
		// Mocking repository response
		Unit unit1 = new Unit(1, "Unit 1");
		Unit unit2 = new Unit(2, "Unit 2");
		List<Unit> units = Arrays.asList(unit1, unit2);
		when(unitRepository.findAll()).thenReturn(units);

		// Calling service method
		List<Unit> result = unitService.getAllUnits();

		// Asserting the result
		assertThat(result).hasSize(2);
		assertThat(result).contains(unit1, unit2);
	}

	@Test
	public void UnitService_FindById_ReturnUnit() {
		int unitId = 1;
		Unit unit = new Unit(1, "Unit");
		when(unitRepository.findById(unitId))
			.thenReturn(Optional.ofNullable(unit));

		Unit findUnit = unitService.getUnitById(unitId);

		assertThat(findUnit).isNotNull();
	}

	@Test
	public void UnitService_DeleteById_Success() {
		// Mocking repository delete method
		int unitId = 1;
		doNothing().when(unitRepository).deleteById(unitId);

		// Calling service method
		unitService.deleteUnitById(unitId);
		assertAll(() -> unitService.deleteUnitById(unitId));
	}

	@Test
	public void UnitService_FindPaginatedUnits() {
		// Mocking repository response
		int pageNum = 1;
		int pageSize = 10;
		String sortField = "name";
		String sortDirection = "ASC";
		Sort sort = Sort.by(Sort.Direction.fromString(sortDirection),
			sortField);
		Pageable pageable = PageRequest.of(pageNum - 1, pageSize, sort);
		Unit unit1 = new Unit(1, "Unit 1");
		Unit unit2 = new Unit(2, "Unit 2");
		List<Unit> units = Arrays.asList(unit1, unit2);
		Page<Unit> page = new PageImpl<>(units, pageable, units.size());
		when(unitRepository.findAll(pageable)).thenReturn(page);

		// Calling service method
		Page<Unit> resultPage = unitService.findPaginated(pageNum, pageSize,
			sortField, sortDirection);

		// Asserting the result
		assertThat(resultPage).isNotNull();
		assertThat(resultPage.getContent()).hasSize(2);
		assertThat(resultPage.getContent()).contains(unit1, unit2);
	}
}
