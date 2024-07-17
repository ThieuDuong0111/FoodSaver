package com.funix.foodsaveradmin.services;

import java.util.Base64;
import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.funix.foodsaveradmin.dto.BannerDTO;
import com.funix.foodsaveradmin.models.Banner;
import com.funix.foodsaveradmin.repositories.IBannerRepository;
import com.funix.foodsaveradmin.utils.ImageUtils;
import com.funix.foodsaveradmin.utils.ParseUtils;

@Service
public class BannerServiceImpl implements IBannerService {
	
	@Autowired
	private IBannerRepository bannerRepository;
	@Autowired
	private ModelMapper modelMapper;

	@Override
	public List<Banner> getAllCategories() {
		return bannerRepository.findAll();
	}

	@Override
	public BannerDTO convertToDto(Banner Banner) {
		return modelMapper.map(Banner, BannerDTO.class);
	}

	@Override
	public Banner convertToEntity(BannerDTO BannerDTO) {
		return modelMapper.map(BannerDTO, Banner.class);
	}

	@Override
	public void saveBanner(BannerDTO BannerDTO) {
		// save image file
		if (!BannerDTO.getImageFile().isEmpty()
			&& BannerDTO.getImageFile() != null) {
			MultipartFile image = BannerDTO.getImageFile();
			try {
				BannerDTO.setImage(
					Base64.getEncoder().encodeToString(
						ImageUtils.resizeImage(image.getBytes(), 960, 540)));
				BannerDTO.setImageType(image.getContentType());
				String array[] = image.getContentType().split("/");
				String imageUrl = ParseUtils.parseImageUrl(image.getBytes());
				if (array.length > 1) {
					BannerDTO.setImageUrl(
						imageUrl
							+ "." + array[1]);
				} else {
					BannerDTO.setImageUrl(
						imageUrl);
				}

			} catch (Exception e) {
				System.out.println("Upload Image Exception: " + e.getMessage());
			}
		}
		this.bannerRepository.save(convertToEntity(BannerDTO));
	}

	@Override
	public BannerDTO getBannerById(int id) {
		Optional<Banner> optionalBanner = bannerRepository.findById(id);
		Banner Banner = null;
		if (optionalBanner.isPresent()) {
			Banner = optionalBanner.get();
		} else {
			throw new RuntimeException("Banner not found for id : " + id);
		}
		return convertToDto(Banner);
	}

	@Override
	public void deleteBannerById(int id) {
		this.bannerRepository.deleteById(id);

	}

	@Override
	public Page<Banner> findPaginated(int pageNum, int pageSize,
		String sortField, String sortDirection) {
		Sort sort = sortDirection.equalsIgnoreCase(Sort.Direction.ASC.name())
			? Sort.by(sortField).ascending()
			: Sort.by(sortField).descending();

		Pageable pageable = PageRequest.of(pageNum - 1, pageSize, sort);
		return this.bannerRepository.findAll(pageable);
	}

}
