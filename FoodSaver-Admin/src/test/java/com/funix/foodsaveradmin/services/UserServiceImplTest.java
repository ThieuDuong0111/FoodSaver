package com.funix.foodsaveradmin.services;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

import java.util.*;

import org.junit.jupiter.api.*;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.modelmapper.ModelMapper;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.data.domain.*;

import com.funix.foodsaveradmin.dto.UserDTO;
import com.funix.foodsaveradmin.models.MyUser;
import com.funix.foodsaveradmin.repositories.IUserRepository;

@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
public class UserServiceImplTest {

	@Mock
	private IUserRepository userRepository;

	@Mock
	private ModelMapper modelMapper;

	@InjectMocks
	private UserServiceImpl userService;

	@Test
	public void convertToDto_ShouldMapCorrectly() {
		MyUser user = new MyUser();
		user.setId(1);
		user.setName("testUser");

		UserDTO userDTO = new UserDTO();
		userDTO.setId(1);
		userDTO.setName("testUser");

		when(modelMapper.map(user, UserDTO.class)).thenReturn(userDTO);

		UserDTO resultDTO = userService.convertToDto(user);

		assertThat(resultDTO).isNotNull();
		assertThat(resultDTO.getId()).isEqualTo(user.getId());
		assertThat(resultDTO.getName()).isEqualTo(user.getName());
	}

	@Test
	public void convertToEntity_ShouldMapCorrectly() {
		UserDTO userDTO = new UserDTO();
		userDTO.setId(1);
		userDTO.setName("testUser");

		MyUser user = new MyUser();
		user.setId(1);
		user.setName("testUser");

		when(modelMapper.map(userDTO, MyUser.class)).thenReturn(user);

		MyUser resultUser = userService.convertToEntity(userDTO);

		assertThat(resultUser).isNotNull();
		assertThat(resultUser.getId()).isEqualTo(userDTO.getId());
		assertThat(resultUser.getName()).isEqualTo(userDTO.getName());
	}

	@Test
	public void getAllUsers_ShouldReturnAllUsers() {
		List<MyUser> userList = Arrays.asList(new MyUser(), new MyUser());
		when(userRepository.findAll()).thenReturn(userList);

		List<MyUser> result = userService.getAllUsers();

		assertThat(result).hasSize(2);
	}
	
	@Test
	public void saveUser_ShouldSaveUserCorrectly() {
		UserDTO userDTO = new UserDTO();
		userDTO.setName("newUser");
		userDTO.setPassword("password");

		MyUser convertedUser = new MyUser();

		when(modelMapper.map(userDTO, MyUser.class)).thenReturn(convertedUser);

		userService.saveUser(userDTO, true);

		verify(userRepository, times(1)).save(convertedUser);
	}

	@Test
	public void deleteUserById_ShouldDeleteUserWithGivenId() {
		int userId = 1;
		userService.deleteUserById(userId);
		verify(userRepository, times(1)).deleteById(userId);
	}

	@Test
	public void findPaginated_ShouldReturnPageOfUsers() {
		int pageNum = 1;
		int pageSize = 10;
		String sortField = "id";
		String sortDirection = "asc";
		int roleId = 1;

		Page<MyUser> page = new PageImpl<>(
			Arrays.asList(new MyUser(), new MyUser()));
		when(userRepository.findAllByRoleId(roleId,
			PageRequest.of(pageNum - 1, pageSize,
				Sort.by(sortDirection.equals("asc") ? Sort.Direction.ASC
					: Sort.Direction.DESC, sortField))))
			.thenReturn(page);

		Page<MyUser> resultPage = userService.findPaginated(pageNum, pageSize,
			sortField, sortDirection, roleId);

		assertThat(resultPage).hasSize(2);
	}

}
