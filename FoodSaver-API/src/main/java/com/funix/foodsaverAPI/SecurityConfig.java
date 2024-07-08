package com.funix.foodsaverAPI;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.funix.foodsaverAPI.services.AuthServiceImpl;
import com.funix.foodsaverAPI.services.JWTFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	@Autowired
	private AuthServiceImpl authServiceImpl;

	@Autowired
	private JWTFilter jWTFilter;

	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http)
		throws Exception {
		http
			.csrf(csrf -> csrf.disable())
			.authorizeHttpRequests((registry) -> registry
				.requestMatchers("/").permitAll()
				.requestMatchers("/api/sign-in/**").permitAll()
				.requestMatchers("/api/sign-up/**").permitAll()
				.requestMatchers("/api/home/**").permitAll()
				.requestMatchers("/api/search/**").permitAll()
				.requestMatchers("/api/product/**").permitAll()
				.requestMatchers("/api/products/**").permitAll()
				.requestMatchers("/api/image/**").permitAll()
				.anyRequest().authenticated())
			.sessionManagement(session -> session
				.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
			.authenticationProvider(authenticationProvider())
			.addFilterBefore(jWTFilter,
				UsernamePasswordAuthenticationFilter.class);
		return http.build();
	}

	@Bean
	public AuthenticationProvider authenticationProvider() throws Exception {
		DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
		provider.setUserDetailsService(authServiceImpl);
		provider.setPasswordEncoder(passwordEncoder());
		return provider;
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	public AuthenticationManager authenticationManager(
		AuthenticationConfiguration config) throws Exception {
		return config.getAuthenticationManager();
	}
}