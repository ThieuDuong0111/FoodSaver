package com.funix.foodsaveradmin.services;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertAll;
import static org.mockito.Mockito.*;

import java.util.*;

import org.junit.jupiter.api.*;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.modelmapper.ModelMapper;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.data.domain.*;
import org.springframework.web.multipart.MultipartFile;

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
	public void UserService_SaveUser_ReturnUser() {
		// Given
		UserDTO UserDTO = new UserDTO();
		UserDTO.setName("Test User");
		UserDTO.setPassword("12345678");
		MultipartFile imageFile = Mockito.mock(MultipartFile.class);
		UserDTO.setImageFile(imageFile);

		// Mocking image processing
		when(imageFile.isEmpty()).thenReturn(false);
		when(imageFile.getContentType()).thenReturn("image/jpeg");
		UserDTO.setImageType("image/jpeg");

		// Mocking repository save method
		when(modelMapper.map(UserDTO, MyUser.class))
			.thenReturn(new MyUser());
		when(userRepository.save(Mockito.any(MyUser.class)))
			.thenReturn(new MyUser());

		// When
		userService.saveUser(UserDTO, true);

		// Then
		verify(userRepository, times(1)).save(Mockito.any(MyUser.class));
	}

	@Test
	public void UserService_ConvertToDto_ShouldMapCorrectly() {
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
	public void UserService_ConvertToEntity_ShouldMapCorrectly() {
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
	public void UserService_WhenGetAll_shouldReturnList() {
		// Mocking repository response
		MyUser user1 = new MyUser();
		MyUser user2 = new MyUser();
		List<MyUser> users = Arrays.asList(user1, user2);
		when(userRepository.findAll()).thenReturn(users);

		// Calling service method
		List<MyUser> result = userService.getAllUsers();

		// Asserting the result
		assertThat(result).hasSize(2);
		assertThat(result).contains(user1, user2);
	}

	@Test
	public void UserService_DeleteUserById_ShouldDeleteUserWithGivenId() {
		int userId = 1;
		doNothing().when(userRepository).deleteById(userId);

		// Calling service method
		userService.deleteUserById(userId);
		assertAll(() -> userService.deleteUserById(userId));
	}

	@Test
	public void UserService_FindPaginated_ShouldReturnPageOfUsers() {
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
