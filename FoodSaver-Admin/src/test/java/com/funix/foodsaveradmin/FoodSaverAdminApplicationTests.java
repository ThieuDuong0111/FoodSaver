package com.funix.foodsaveradmin;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

@ExtendWith(SpringExtension.class)
@SpringBootTest
class FoodSaverAdminApplicationTests {

	@Autowired
	private ModelMapper modelMapper;

	@Test
	void contextLoads() {
	}

}
