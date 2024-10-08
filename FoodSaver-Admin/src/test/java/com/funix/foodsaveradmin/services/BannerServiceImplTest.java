package com.funix.foodsaveradmin.services;

import com.funix.foodsaveradmin.dto.BannerDTO;
import com.funix.foodsaveradmin.models.Banner;
import com.funix.foodsaveradmin.repositories.IBannerRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertAll;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class BannerServiceImplTest {

	@Mock
	private IBannerRepository bannerRepository;

	@Mock
	private ModelMapper modelMapper;

	@InjectMocks
	private BannerServiceImpl bannerService;

	@Test
	public void BannerService_SaveBanner_ReturnBanner() throws Exception {
		// Mocking input DTO
		BannerDTO bannerDTO = new BannerDTO();
		bannerDTO.setName("Banner Test");

		Banner convertedBanner = new Banner();

		// Mocking repository save method
		when(modelMapper.map(bannerDTO, Banner.class))
			.thenReturn(convertedBanner);

		bannerService.saveBanner(bannerDTO);

		verify(bannerRepository, times(1)).save(convertedBanner);
	}

	@Test
	public void BannerService_WhenGetAll_shouldReturnList() {
		// Mocking repository response
		Banner banner1 = new Banner(1, "Banner 1", "image1", "url1",
			"image/png");
		Banner banner2 = new Banner(2, "Banner 2", "image2", "url2",
			"image/jpeg");
		List<Banner> banners = Arrays.asList(banner1, banner2);
		when(bannerRepository.findAll()).thenReturn(banners);

		// Calling service method
		List<Banner> result = bannerService.getAllBanners();

		// Asserting the result
		assertThat(result).hasSize(2);
		assertThat(result).contains(banner1, banner2);
	}

	@Test
	public void BannerService_FindById_ReturnBanner() {
		int bannerId = 1;
		Banner banner = new Banner(bannerId, "Banner 1", "image1", "url1",
			"image/png");
		when(bannerRepository.findById(bannerId))
			.thenReturn(Optional.ofNullable(banner));

		Banner findBanner = bannerService.getBannerById(bannerId);

		assertThat(findBanner).isNotNull();
	}

	@Test
	public void BannerService_DeleteBannerById_Success() {
		// Mocking repository delete method
		int bannerId = 1;
		doNothing().when(bannerRepository).deleteById(bannerId);

		// Calling service method
		bannerService.deleteBannerById(bannerId);
		assertAll(() -> bannerService.deleteBannerById(bannerId));

	}

	@Test
	public void BannerService_FindPaginatedBanners() {
		// Mocking repository response
		int pageNum = 1;
		int pageSize = 10;
		String sortField = "name";
		String sortDirection = "ASC";
		Sort sort = Sort.by(Sort.Direction.fromString(sortDirection),
			sortField);
		Pageable pageable = PageRequest.of(pageNum - 1, pageSize, sort);
		Banner banner1 = new Banner(1, "Banner 1", "image1", "url1",
			"image/png");
		Banner banner2 = new Banner(2, "Banner 2", "image2", "url2",
			"image/jpeg");
		List<Banner> banners = Arrays.asList(banner1, banner2);
		Page<Banner> page = new PageImpl<>(banners, pageable, banners.size());
		when(bannerRepository.findAll(pageable)).thenReturn(page);

		// Calling service method
		Page<Banner> resultPage = bannerService.findPaginated(pageNum, pageSize,
			sortField, sortDirection);

		// Asserting the result
		assertThat(resultPage).isNotNull();
		assertThat(resultPage.getContent()).hasSize(2);
		assertThat(resultPage.getContent()).contains(banner1, banner2);
	}
}
