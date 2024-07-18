//package com.funix.foodsaveradmin.services;
//
//import com.funix.foodsaveradmin.dto.UserDTO;
//import com.funix.foodsaveradmin.models.MyUser;
//import com.funix.foodsaveradmin.repositories.IUserRepository;
//import com.funix.foodsaveradmin.services.UserServiceImpl;
//
//import jakarta.transaction.Transactional;
//
//import org.junit.jupiter.api.BeforeEach;
//import org.junit.jupiter.api.Test;
//import org.mockito.InjectMocks;
//import org.mockito.Mock;
//import org.mockito.MockitoAnnotations;
//import org.modelmapper.ModelMapper;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
//import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
//import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
//import org.springframework.data.domain.Page;
//import org.springframework.data.domain.PageImpl;
//import org.springframework.data.domain.PageRequest;
//import org.springframework.data.domain.Pageable;
//import org.springframework.data.domain.Sort;
//
//import java.util.Arrays;
//import java.util.List;
//import java.util.Optional;
//
//import static org.junit.jupiter.api.Assertions.*;
//import static org.mockito.ArgumentMatchers.any;
//import static org.mockito.ArgumentMatchers.anyInt;
//import static org.mockito.Mockito.*;
//
//@DataJpaTest
//@AutoConfigureTestDatabase(replace = Replace.NONE)
//public class UserServiceImplTest {
//
//	@Mock
//	private IUserRepository userRepository;
//
//	@Mock
//	private ModelMapper modelMapper;
//
//	@InjectMocks
//	private UserServiceImpl userService;
//
//	@BeforeEach
//	public void setUp() {
//		MockitoAnnotations.openMocks(this);
//	}
//
//	@Test
//	public void testGetAllUsers() {
//		MyUser user = new MyUser();
//		List<MyUser> userList = Arrays.asList(user);
//		when(userRepository.findAll()).thenReturn(userList);
//		List<MyUser> result = userService.getAllUsers();
//		assertEquals(1, result.size());
//		verify(userRepository, times(1)).findAll();
//	}
//
//	@Test
////	@Rollback
//	public void testSaveUser() {
//		UserDTO userDTO = new UserDTO("thieuduong", "12345678", "0707046410",
//			"duongthieu1995@gmail.com", "107 Bau Cat 2");
//		MyUser user = new MyUser();
//		when(modelMapper.map(any(UserDTO.class), eq(MyUser.class)))
//			.thenReturn(user);
//		userService.saveUser(userDTO, true);
//		verify(userRepository, times(1)).save(any(MyUser.class));
//	}
//
//	@Test
//	public void testGetUserById() {
//		MyUser user = new MyUser();
//		UserDTO userDTO = new UserDTO();
//		when(userRepository.findById(anyInt())).thenReturn(Optional.of(user));
//		when(modelMapper.map(any(MyUser.class), eq(UserDTO.class)))
//			.thenReturn(userDTO);
//		UserDTO result = userService.getUserById(1);
//		assertNotNull(result);
//		verify(userRepository, times(1)).findById(anyInt());
//	}
//
//	@Test
//	public void testDeleteUserById() {
//		userService.deleteUserById(1);
//		verify(userRepository, times(1)).deleteById(anyInt());
//	}
//
//}
