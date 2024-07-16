package com.funix.foodsaverAPI.services;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.funix.foodsaverAPI.dto.CartItemDTO;
import com.funix.foodsaverAPI.dto.ProductDTO;
import com.funix.foodsaverAPI.models.Product;
import com.funix.foodsaverAPI.repositories.IFeedBackRepository;
import com.funix.foodsaverAPI.repositories.IProductRepository;

@Service
public class ProductServiceImpl implements IProductService {

	@Autowired
	private IProductRepository productRepository;

	@Autowired
	private IFeedBackRepository feedBackRepository;

	@Autowired
	private ICategoryService categoryService;

	@Autowired
	private IUserService userService;

	@Autowired
	private ModelMapper modelMapper;

	@Override
	public ProductDTO convertToDto(Product product) {
		ProductDTO productDTO = modelMapper.map(product, ProductDTO.class);
//		if (product.getImageUrl() != null) {
//			productDTO.setImageUrl("http://localhost:8080/api/image/product/"
//				+ product.getImageUrl());
//		}
		productDTO.setRating(calculateRating(product.getId()));
		productDTO
			.setCategory(categoryService.convertToDto(product.getCategory()));
		productDTO
			.setCreator(userService.convertToDto(product.getCreator()));
		return productDTO;
	}

	@Override
	public ProductDTO convertFromCartItemToProductDTO(CartItemDTO cartItemDTO) {
		ProductDTO productDTO = modelMapper.map(cartItemDTO.getCartProduct(),
			ProductDTO.class);
//		if (cartItemDTO.getCartProduct().getImageUrl() != null) {
//			productDTO.setImageUrl("http://localhost:8080/api/image/product/"
//				+ cartItemDTO.getCartProduct().getImageUrl());
//		}
		return productDTO;
	}

	@Override
	public List<ProductDTO> getAllProducts() {
		return productRepository.findAll().stream()
			.map(this::convertToDto)
			.collect(Collectors.toList());
	}

	@Override
	public Product getProductById(int id) {
		Optional<Product> optionalProduct = productRepository.findById(id);
		Product product = null;
		if (optionalProduct.isPresent()) {
			product = optionalProduct.get();
			return product;
		} else {
			return null;
		}
	}

	@Override
	public List<ProductDTO> getTop20Products() {
		return productRepository.getTop20Products().stream()
			.map(this::convertToDto)
			.collect(Collectors.toList());
	}

	@Override
	public List<ProductDTO> findByCategoryId(int categoryId) {
		return productRepository.findByCategoryId(categoryId).stream()
			.map(this::convertToDto)
			.collect(Collectors.toList());
	}

	@Override
	public List<ProductDTO> searchByName(String name) {
		return productRepository.searchByName(name).stream()
			.map(this::convertToDto)
			.collect(Collectors.toList());
	}

	@Override
	public void deleteProductById(int id) {
		this.productRepository.deleteById(id);
	}

	@Override
	public Product getProductByImageUrl(String url) {
		Optional<Product> optionalProduct = productRepository
			.findByImageUrl(url);
		Product product = null;
		if (optionalProduct.isPresent()) {
			product = optionalProduct.get();
			return product;
		} else {
			return null;
		}
	}

	@Override
	public Double calculateRating(int productId) {
		return feedBackRepository
			.findAverageRatingByProductId(productId) == null ? 5.0
				: feedBackRepository.findAverageRatingByProductId(productId);
	}

}
