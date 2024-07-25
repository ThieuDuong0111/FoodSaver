package com.funix.foodsaveradmin.repositories;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import com.funix.foodsaveradmin.models.MyUser;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;
import java.util.Optional;

@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
public class UserRepositoryTest {

	@Autowired
	private IUserRepository userRepository;

	@Test
	public void UserRepository_Save_ReturnUser() {
		MyUser user = new MyUser();
		user.setName("nguyenduong");
		user.setPassword("12345678");
		user.setPhone("0707045410");
		user.setEmail("nguyenduong1995@gmail.com");
		user.setAddress("107 Bau Cat 2");

		MyUser savedUser = userRepository.save(user);

		assertThat(savedUser.getName()).isEqualTo("nguyenduong");
		assertThat(savedUser.getPhone()).isEqualTo("0707045410");
		assertThat(savedUser.getEmail()).isEqualTo("nguyenduong1995@gmail.com");
		assertThat(savedUser.getAddress()).isEqualTo("107 Bau Cat 2");
	}

	@Test
	public void UserRepository_GetAll_ReturnListUser() {
		MyUser user1 = new MyUser();
		user1.setName("nguyenduong1");
		user1.setPassword("12345678");
		user1.setPhone("0707045410");
		user1.setEmail("nguyenduong1994@gmail.com");
		user1.setAddress("107 Bau Cat 2");

		MyUser user2 = new MyUser();
		user2.setName("nguyenduong2");
		user2.setPassword("12345678");
		user2.setPhone("0707045411");
		user2.setEmail("nguyenduong1995@gmail.com");
		user2.setAddress("107 Bau Cat 2");

		userRepository.save(user1);
		userRepository.save(user2);

		List<MyUser> userList = userRepository.findAll();

		assertThat(userList).isNotNull();
	}

	@Test
	public void UserRepository_FindById_Found() {
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
	public void UserRepository_FindById_NotFound() {
		// Attempt to find a user that doesn't exist
		Optional<MyUser> found = userRepository.findById(100);
		// Verify no user is found
		assertThat(found).isNotPresent();
	}

	@Test
	public void UserRepository_FindByName_Found() {
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
	public void UserRepository_FindByName_NotFound() {
		Optional<MyUser> found = userRepository.findByName("testnotfound");
		// Verify the user was found and the name is correct
		assertThat(found).isNotPresent();
	}

	@Test
	public void UserRepository_UpdateUser_Success() {
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
		found.get().setPassword("passwordUpdate");
		found.get().setPhone("1234567899");
		found.get().setEmail("newuserupdate@example.com");
		found.get().setAddress("New Address Update");
		userRepository.save(user);
		// Verify the user was saved correctly
		Optional<MyUser> foundUpdated = userRepository
			.findById(found.get().getId());
		assertThat(foundUpdated).isPresent();
		assertThat(foundUpdated.get().getName()).isEqualTo("newUserUpdate");
		assertThat(foundUpdated.get().getPassword())
			.isEqualTo("passwordUpdate");
		assertThat(foundUpdated.get().getEmail())
			.isEqualTo("newuserupdate@example.com");
		assertThat(foundUpdated.get().getPhone()).isEqualTo("1234567899");
		assertThat(foundUpdated.get().getAddress())
			.isEqualTo("New Address Update");
	}

	@Test
	public void UserRepository_DeleteUser_Success() {
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
