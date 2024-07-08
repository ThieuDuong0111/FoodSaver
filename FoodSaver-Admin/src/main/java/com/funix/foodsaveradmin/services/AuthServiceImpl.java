package com.funix.foodsaveradmin.services;

import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.funix.foodsaveradmin.models.CustomUserDetails;
import com.funix.foodsaveradmin.models.MyUser;
import com.funix.foodsaveradmin.repositories.IUserRepository;

@Service
public class AuthServiceImpl implements UserDetailsService {
	@Autowired
	private IUserRepository userRepository;

	@Override
	public CustomUserDetails loadUserByUsername(String name)
		throws UsernameNotFoundException {

		Optional<MyUser> user = userRepository.findByName(name);
		if (user.isPresent()) {
			Set<SimpleGrantedAuthority> authorities = new HashSet<SimpleGrantedAuthority>();
			authorities.add(
				new SimpleGrantedAuthority(
					"ROLE_" + user.get().getRole().getName()));
			return new CustomUserDetails(user.get().getId(),
				user.get().getName(),
				user.get().getPassword(), user.get().getAvatar(), authorities);

		}
		throw new UsernameNotFoundException(name);
	}

}
