package com.funix.foodsaveradmin.repositories;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import com.funix.foodsaveradmin.models.MyUser;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.Optional;

@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
public class UserRepositoryTest {

	@Autowired
	private IUserRepository userRepository;

	@Test
	public void testFindByName() {
		// Create a new user and save it to the repository
		MyUser user = new MyUser();
		user.setName("nguyenduong");
		user.setPassword("12345678");
		user.setPhone("0707045410");
		user.setEmail("nguyenduong1995@gmail.com");
		user.setAddress("107 Bau Cat 2");
		userRepository.save(user);
		// Retrieve the user by name
		Optional<MyUser> found = userRepository.findByName("nguyenduong");
		// Verify the user was found and the name is correct
		assertThat(found).isPresent();
		assertThat(found.get().getName()).isEqualTo("nguyenduong");
	}

	@Test
	public void testFindByName_NotFound() {
		// Attempt to find a user that doesn't exist
		Optional<MyUser> found = userRepository.findByName("nonexistent");
		// Verify no user is found
		assertThat(found).isNotPresent();
	}

	@Test
	public void testFindById() {
		// Create a new user and save it to the repository
		MyUser user = new MyUser();
		user.setName("nguyenduong");
		user.setPassword("12345678");
		user.setPhone("0707045410");
		user.setEmail("nguyenduong1995@gmail.com");
		user.setAddress("107 Bau Cat 2");
		userRepository.save(user);

		// Retrieve the user by ID
		Optional<MyUser> found = userRepository.findById(user.getId());

		// Verify the user was found and the ID is correct
		assertThat(found).isPresent();
		assertThat(found.get().getId()).isEqualTo(user.getId());
	}

	@Test
	public void testSaveUser() {
		// Create a new user and save it to the repository
		MyUser user = new MyUser();
		user.setName("newuser");
		user.setPassword("password");
		user.setPhone("1234567890");
		user.setEmail("newuser@example.com");
		user.setAddress("New Address");
		userRepository.save(user);
		// Retrieve the user by name
		Optional<MyUser> found = userRepository.findByName("newuser");
		// Verify the user was saved correctly
		assertThat(found).isPresent();
		assertThat(found.get().getName()).isEqualTo("newuser");
		assertThat(found.get().getEmail()).isEqualTo("newuser@example.com");
	}

	@Test
	public void testUpdateUser() {
		// Create a new user and save it to the repository
		MyUser user = new MyUser();
		user.setName("newuser");
		user.setPassword("password");
		user.setPhone("1234567890");
		user.setEmail("newuser@example.com");
		user.setAddress("New Address");
		userRepository.save(user);
		// Retrieve the user by name
		Optional<MyUser> found = userRepository.findByName("newuser");
		found.get().setName("newUserUpdate");
		user.setPassword("passwordUpdate");
		user.setPhone("1234567899");
		user.setEmail("newuserupdate@example.com");
		user.setAddress("New Address Update");
		userRepository.save(user);
		// Verify the user was saved correctly
		assertThat(found).isPresent();
		assertThat(found.get().getName()).isEqualTo("newUserUpdate");
		assertThat(found.get().getPassword()).isEqualTo("passwordUpdate");
		assertThat(found.get().getEmail())
			.isEqualTo("newuserupdate@example.com");
		assertThat(found.get().getPhone()).isEqualTo("1234567899");
		assertThat(found.get().getAddress()).isEqualTo("New Address Update");
	}

	@Test
	public void testDeleteUser() {
		// Create a new user and save it to the repository
		MyUser user = new MyUser();
		user.setName("userToDelete");
		user.setPassword("password");
		user.setPhone("1234567890");
		user.setEmail("userToDelete@example.com");
		user.setAddress("Address to delete");
		userRepository.save(user);
		// Delete the user
		userRepository.deleteById(user.getId());
		// Verify the user was deleted
		Optional<MyUser> found = userRepository.findById(user.getId());
		assertThat(found).isNotPresent();
	}
}
