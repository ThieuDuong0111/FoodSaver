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
import com.funix.foodsaverAPI.utils.ParseUtils;

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
		productDTO.setIsOutOfStock(product.getQuantity() < 1);
		productDTO
			.setIsExpired(ParseUtils.checkIsExpired(product.getExpiredDate()));
		// Rating counts
		productDTO.setRatingsCount(
			feedBackRepository.countRatingsByProductId(product.getId()));
		// Rating 1
		productDTO.setRating1Count(
			feedBackRepository.countRatingPointByProductId(product.getId(), 1));
		// Rating 2
		productDTO.setRating2Count(
			feedBackRepository.countRatingPointByProductId(product.getId(), 2));
		// Rating 3
		productDTO.setRating3Count(
			feedBackRepository.countRatingPointByProductId(product.getId(), 3));
		// Rating 4
		productDTO.setRating4Count(
			feedBackRepository.countRatingPointByProductId(product.getId(), 4));
		// Rating 5
		productDTO.setRating5Count(
			feedBackRepository.countRatingPointByProductId(product.getId(), 5));
		// -------
		productDTO.setCommentsCount(
			feedBackRepository.countCommentsByProductId(product.getId()));
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
	public List<ProductDTO> getTop20NewestProducts() {
		return productRepository.getTop20Products().stream()
			.map(this::convertToDto)
			.collect(Collectors.toList());
	}

	@Override
	public List<ProductDTO> getTop5MostPurchaseProducts() {
		return productRepository.getTop5MostPurchaseProducts().stream()
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
	public List<ProductDTO> findByStoreId(int storeId) {
		return productRepository.findByCreatorId(storeId).stream()
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
		double number = feedBackRepository
			.findAverageRatingByProductId(productId) == null ? 5.0
				: feedBackRepository.findAverageRatingByProductId(productId);
		number = Math.floor(number * 10) / 10;
		return number;
	}

}
