package com.funix.foodsaverAPI.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.funix.foodsaverAPI.models.MyUser;
import com.funix.foodsaverAPI.repositories.IUserRepository;

@Service
public class AuthServiceImpl implements UserDetailsService {
	@Autowired
	private IUserRepository userRepository;

	@Override
	public UserDetails loadUserByUsername(String name)
		throws UsernameNotFoundException {

		Optional<MyUser> user = userRepository.findByName(name);
		if (user.isPresent()) {
			return User
				.withUsername(user.get().getName())
				.password(user.get().getPassword())
				.roles(user.get().getRole().getName())
				.build();
		}
		throw new UsernameNotFoundException(name);
	}
}
