package com.funix.foodsaveradmin.services;

import java.util.Base64;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.funix.foodsaveradmin.dto.ProductDTO;
import com.funix.foodsaveradmin.models.Product;
import com.funix.foodsaveradmin.repositories.IProductRepository;
import com.funix.foodsaveradmin.utils.ImageUtils;
import com.funix.foodsaveradmin.utils.ParseUtils;

@Service
public class ProductServiceImpl implements IProductService {

	@Autowired
	private IProductRepository productRepository;

	@Autowired
	private ModelMapper modelMapper;

	@Override
	public ProductDTO convertToDto(Product product) {
		return modelMapper.map(product, ProductDTO.class);
	}

	@Override
	public Product convertToEntity(ProductDTO productDTO) {
		return modelMapper.map(productDTO, Product.class);
	}

	@Override
	@Transactional
	public void saveProduct(ProductDTO productDTO) {
		// save image file
		if (!productDTO.getImageFile().isEmpty()
			&& productDTO.getImageFile() != null) {
			MultipartFile image = productDTO.getImageFile();
			try {
				productDTO.setImage(
					Base64.getEncoder().encodeToString(
						ImageUtils.resizeImage(image.getBytes(), 1000, 1000)));
				productDTO.setImageType(image.getContentType());
				String array[] = image.getContentType().split("/");
				String imageUrl = ParseUtils.parseImageUrl(image.getBytes());
				if (array.length > 1) {
					productDTO.setImageUrl(
						imageUrl
							+ "." + array[1]);
				} else {
					productDTO.setImageUrl(imageUrl);
				}
			} catch (Exception e) {
				System.out.println("Upload Image Exception: " + e.getMessage());
			}
		}
		this.productRepository.save(convertToEntity(productDTO));
	}

	@Override
	public ProductDTO getProductById(int id) {
		Optional<Product> optionalProduct = productRepository.findById(id);
		Product product = null;
		if (optionalProduct.isPresent()) {
			product = optionalProduct.get();
		} else {
			throw new RuntimeException("Product not found for id : " + id);
		}
		return convertToDto(product);
	}

	@Override
	public void deleteProductById(int id) {
		this.productRepository.deleteById(id);
	}

	@Override
	public Page<Product> findPaginated(int pageNum, int pageSize,
		String sortField,
		String sortDirection, int creator_id) {
		Sort sort = sortDirection.equalsIgnoreCase(Sort.Direction.ASC.name())
			? Sort.by(sortField).ascending()
			: Sort.by(sortField).descending();

		Pageable pageable = PageRequest.of(pageNum - 1, pageSize, sort);
		return this.productRepository.findAllByCreatorId(creator_id, pageable);
	}
}
