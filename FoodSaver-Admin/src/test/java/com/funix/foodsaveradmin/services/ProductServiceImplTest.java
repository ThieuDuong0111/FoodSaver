package com.funix.foodsaveradmin.services;

import com.funix.foodsaveradmin.dto.ProductDTO;
import com.funix.foodsaveradmin.models.Product;
import com.funix.foodsaveradmin.repositories.IProductRepository;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.modelmapper.ModelMapper;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.text.ParseException;

import static org.mockito.Mockito.*;

@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
public class ProductServiceImplTest {

	@Mock
	private IProductRepository productRepository;

	@Mock
	private ModelMapper modelMapper;

	@InjectMocks
	private ProductServiceImpl productService;

	@Test
	public void testSaveProduct() throws IOException, ParseException {
		// Given
		ProductDTO productDTO = new ProductDTO();
		productDTO.setName("Test Product");
		MultipartFile imageFile = Mockito.mock(MultipartFile.class);
		productDTO.setImageFile(imageFile);

		// Mocking image processing
		String imageUrl = "testImageUrl";
		when(imageFile.isEmpty()).thenReturn(false);
		when(imageFile.getContentType()).thenReturn("image/jpeg");
		when(imageFile.getBytes()).thenReturn(new byte[0]);
		productDTO.setImageType("image/jpeg");
		productDTO.setImageUrl(imageUrl);

		// Mocking repository save method
		when(modelMapper.map(productDTO, Product.class))
			.thenReturn(new Product());
		when(productRepository.save(Mockito.any(Product.class)))
			.thenReturn(new Product());
		// When
		productService.saveProduct(productDTO);
		// Then
		verify(productRepository, times(1)).save(Mockito.any(Product.class));
	}

	@Test
	public void testDeleteProductById() {
		// Given
		int productId = 1;
		// When
		productService.deleteProductById(productId);
		// Then
		verify(productRepository, times(1)).deleteById(productId);
	}
}
