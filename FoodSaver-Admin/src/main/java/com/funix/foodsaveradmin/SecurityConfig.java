package com.funix.foodsaveradmin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.funix.foodsaveradmin.services.AuthServiceImpl;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	@Autowired
	private AuthServiceImpl authServiceImpl;

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	protected UserDetailsService userDetailsService(
		PasswordEncoder passwordEncoder) {
		return authServiceImpl;
	}

	@Bean
	protected AuthenticationProvider authenticationProvider(
		PasswordEncoder passwordEncoder) {
		DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
		provider.setUserDetailsService(authServiceImpl);
		provider.setPasswordEncoder(passwordEncoder);
		return provider;
	}

	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http)
		throws Exception {
		http
			.authorizeHttpRequests((registry) -> registry
				.requestMatchers("/admin/**").hasRole("admin")
				.requestMatchers("/food_creator/**").hasRole("food_creator")
				.requestMatchers("/assets/**", "/dist/**", "/fonts/**",
					"/js/**", "/libs/**", "/scss/**", "/css/**")
				.permitAll()
				.anyRequest().authenticated())

			.formLogin(
				httpSecurityFormLoginConfigurer -> httpSecurityFormLoginConfigurer
					.loginPage("/login")
					.successHandler(new AuthenticationSuccessHandler())
					.permitAll())

			.logout((logout) -> logout
				.logoutUrl("/perform_logout")
				.logoutSuccessUrl("/login")
				.permitAll());

		return http.build();
	}

	@Bean
	WebSecurityCustomizer configureWebSecurity() {
		return (web) -> web.ignoring().requestMatchers("/assets/**", "/dist/**",
			"/fonts/**",
			"/js/**", "/libs/**", "/scss/**", "/css/**");
	}

}