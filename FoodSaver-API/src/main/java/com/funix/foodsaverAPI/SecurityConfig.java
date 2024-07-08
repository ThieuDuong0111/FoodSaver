package com.funix.foodsaverAPI;

import javax.crypto.spec.SecretKeySpec;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.jose.jws.MacAlgorithm;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.NimbusJwtDecoder;
import org.springframework.security.web.SecurityFilterChain;

import com.funix.foodsaverAPI.services.AuthServiceImpl;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	@Value("${security.jwt.secret-key}")
	private String jwtSecretKey;

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
			.oauth2ResourceServer(
				oauth2 -> oauth2.jwt(Customizer.withDefaults()))
			.sessionManagement(session -> session
				.sessionCreationPolicy(SessionCreationPolicy.STATELESS));
		return http.build();
	}

	@Bean
	public JwtDecoder jwtDecoder() {
		var secretKey = new SecretKeySpec(jwtSecretKey.getBytes(), "");
		return NimbusJwtDecoder.withSecretKey(secretKey)
			.macAlgorithm(MacAlgorithm.HS256).build();
	}

	@Bean
	public AuthenticationManager authenticationManagerBean(
		AuthServiceImpl authServiceImpl) throws Exception {
		DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
		provider.setUserDetailsService(authServiceImpl);
		provider.setPasswordEncoder(new BCryptPasswordEncoder());
		return new ProviderManager(provider);
	}
}