package com.funix.foodsaverAPI.utils;

import java.time.Instant;

import org.springframework.security.oauth2.jose.jws.MacAlgorithm;
import org.springframework.security.oauth2.jwt.JwsHeader;
import org.springframework.security.oauth2.jwt.JwtClaimsSet;
import org.springframework.security.oauth2.jwt.JwtEncoderParameters;
import org.springframework.security.oauth2.jwt.NimbusJwtEncoder;

import com.funix.foodsaverAPI.models.MyUser;
import com.nimbusds.jose.jwk.source.ImmutableSecret;

public class JWTUtils {
	private static String jwtSecretKey = "3cfa434asf127hcg6jk519ko76rtdbtw";

	private static String jwtIssuer = "Food Saver API";

	public static String createJwtoken(MyUser myUser) {
		System.out.println(jwtSecretKey);
		System.out.println(jwtIssuer);
		Instant now = Instant.now();
		JwtClaimsSet claims = JwtClaimsSet.builder()
			.issuer(jwtIssuer)
			.issuedAt(now)
			.expiresAt(now.plusSeconds(24 * 3600))
			.subject(myUser.getName())
			.claim("role", myUser.getRole().getName())
			.build();

		var encoder = new NimbusJwtEncoder(
			new ImmutableSecret<>(jwtSecretKey.getBytes()));
		var params = JwtEncoderParameters
			.from(JwsHeader.with(MacAlgorithm.HS256).build(), claims);
		return encoder.encode(params).getTokenValue();
	}
}
