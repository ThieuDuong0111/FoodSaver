package com.funix.foodsaveradmin.repositories;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import com.funix.foodsaveradmin.models.Unit;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.Optional;

@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
public class UnitRepositoryTest {

	@Autowired
	private IUnitRepository unitRepository;

	@Test
	public void testSaveUnit() {
		// Create a new unit and save it to the repository
		Unit unit = new Unit();
		unit.setName("Kilogram");
		unitRepository.save(unit);

		// Retrieve the unit by name
		Optional<Unit> found = unitRepository.findByName("Kilogram");

		// Verify the unit was saved correctly
		assertThat(found).isPresent();
		assertThat(found.get().getName()).isEqualTo("Kilogram");
	}

	@Test
	public void testFindByName() {
		// Create a new unit and save it to the repository
		Unit unit = new Unit();
		unit.setName("Liter");
		unitRepository.save(unit);

		// Retrieve the unit by name
		Optional<Unit> found = unitRepository.findByName("Liter");

		// Verify the unit was found and the name is correct
		assertThat(found).isPresent();
		assertThat(found.get().getName()).isEqualTo("Liter");
	}

	@Test
	public void testFindByName_NotFound() {
		// Attempt to find a unit that doesn't exist
		Optional<Unit> found = unitRepository.findByName("Nonexistent");

		// Verify no unit is found
		assertThat(found).isNotPresent();
	}

	@Test
	public void testFindById() {
		// Create a new unit and save it to the repository
		Unit unit = new Unit();
		unit.setName("Gram");
		unitRepository.save(unit);

		// Retrieve the unit by ID
		Optional<Unit> found = unitRepository.findById(unit.getId());

		// Verify the unit was found and the ID is correct
		assertThat(found).isPresent();
		assertThat(found.get().getId()).isEqualTo(unit.getId());
	}

	@Test
	public void testUpdateUnit() {
		// Create a new unit and save it to the repository
		Unit unit = new Unit();
		unit.setName("Piece");
		unitRepository.save(unit);

		// Retrieve the unit by name
		Optional<Unit> found = unitRepository.findByName("Piece");

		// Update the unit's name
		Unit updatedUnit = found.get();
		updatedUnit.setName("UpdatedPiece");
		unitRepository.save(updatedUnit);

		// Verify the unit was updated correctly
		Optional<Unit> foundUpdated = unitRepository
			.findById(updatedUnit.getId());
		assertThat(foundUpdated).isPresent();
		assertThat(foundUpdated.get().getName()).isEqualTo("UpdatedPiece");
	}

	@Test
	public void testDeleteUnit() {
		// Create a new unit and save it to the repository
		Unit unit = new Unit();
		unit.setName("ToDelete");
		unitRepository.save(unit);

		// Delete the unit
		unitRepository.deleteById(unit.getId());

		// Verify the unit was deleted
		Optional<Unit> found = unitRepository.findById(unit.getId());
		assertThat(found).isNotPresent();
	}
}
