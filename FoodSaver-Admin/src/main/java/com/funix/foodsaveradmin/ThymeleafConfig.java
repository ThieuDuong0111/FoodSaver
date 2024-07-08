//package com.funix.foodsaveradmin;
//
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.thymeleaf.spring6.SpringTemplateEngine;
//import org.thymeleaf.spring6.dialect.SpringStandardDialect;
//import org.thymeleaf.spring6.templateresolver.SpringResourceTemplateResolver;
//
//import com.funix.foodsaveradmin.utils.ParseUtility;
//
//import java.util.HashMap;
//import java.util.Map;
//
//@Configuration
//public class ThymeleafConfig {
//
//	@Bean
//	public SpringStandardDialect springStandardDialect() {
//		return new SpringStandardDialect();
//	}
//
//	@Bean
//	public SpringTemplateEngine templateEngine(
//		SpringResourceTemplateResolver templateResolver,
//		SpringStandardDialect dialect) {
//		SpringTemplateEngine templateEngine = new SpringTemplateEngine();
//		templateEngine.setTemplateResolver(templateResolver);
//		templateEngine.addDialect(dialect);
//		templateEngine.addDialect(new SpringDataDialect()); // Thêm Spring Data
//															// Dialect nếu cần
//		templateEngine.addDialect("roleUtils", roleUtils());
//		return templateEngine;
//	}
//
//	@Bean
//	public RoleUtils roleUtils() {
//		return new RoleUtils();
//	}
//
//}
