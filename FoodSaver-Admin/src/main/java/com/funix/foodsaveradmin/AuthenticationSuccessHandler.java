package com.funix.foodsaveradmin;

import java.io.IOException;
import java.util.Set;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AuthenticationSuccessHandler
	extends SavedRequestAwareAuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request,
		HttpServletResponse response, Authentication authentication)
		throws ServletException, IOException {
		setAlwaysUseDefaultTargetUrl(true);
		Set<String> roles = AuthorityUtils
			.authorityListToSet(authentication.getAuthorities());
		if (roles.contains("ROLE_admin")) {
			setDefaultTargetUrl(
				"/admin/dashboard");
		} else if (roles.contains("ROLE_food_creator")) {
			setDefaultTargetUrl(
				"/food_creator/dashboard");
		} else {
			setDefaultTargetUrl("/login");
		}

		super.onAuthenticationSuccess(request, response, authentication);
	}

}
