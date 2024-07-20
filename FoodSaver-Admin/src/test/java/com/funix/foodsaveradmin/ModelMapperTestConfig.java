package com.funix.foodsaveradmin;

import org.modelmapper.ModelMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ModelMapperTestConfig {
	@Bean
	public ModelMapper modelMapper() {
		return new ModelMapper();
	}
}
