package com.funix.foodsaveradmin.repositories;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import com.funix.foodsaveradmin.models.Banner;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;
import java.util.Optional;

@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
public class BannerRepositoryTest {

	@Autowired
	private IBannerRepository bannerRepository;

	@Test
	public void BannerRepository_Save_ReturnBanner() {
		Banner banner = new Banner();
		banner.setName("Promo Banner");
		banner.setImageUrl("https://example.com/banner.jpg");
		banner.setImageType("jpg");

		Banner savedBanner = bannerRepository.save(banner);

		assertThat(savedBanner.getName()).isEqualTo("Promo Banner");
		assertThat(savedBanner.getImageUrl())
			.isEqualTo("https://example.com/banner.jpg");
		assertThat(savedBanner.getImageType()).isEqualTo("jpg");
	}

	@Test
	public void BannerRepository_GetAll_ReturnListBanner() {
		Banner banner1 = new Banner();
		banner1.setName("Banner 1");

		Banner banner2 = new Banner();
		banner2.setName("Banner 2");

		bannerRepository.save(banner1);
		bannerRepository.save(banner2);

		List<Banner> bannerList = bannerRepository.findAll();

		assertThat(bannerList).isNotNull();
	}

	@Test
	public void BannerRepository_FindById_Found() {
		Banner banner = new Banner();
		banner.setName("Special Offer Banner");
		bannerRepository.save(banner);

		Optional<Banner> found = bannerRepository.findById(banner.getId());

		assertThat(found).isPresent();
		assertThat(found.get().getId()).isEqualTo(banner.getId());
	}
	
	@Test
	public void BannerRepository_FindById_NotFound() {
		Banner banner = new Banner();
		banner.setId(1);
		banner.setName("Special Offer Banner");
		bannerRepository.save(banner);

		Optional<Banner> found = bannerRepository.findById(2);

		assertThat(found).isNotPresent();
	}

	@Test
	public void BannerRepository_FindByName_Found() {
		Banner banner = new Banner();
		banner.setName("Special Offer Banner");
		bannerRepository.save(banner);

		Optional<Banner> found = bannerRepository.findByName(banner.getName());

		assertThat(found).isPresent();
		assertThat(found.get().getName()).isEqualTo(banner.getName());
	}

	@Test
	public void BannerRepository_FindByName_NotFound() {
		Optional<Banner> found = bannerRepository.findByName("Nonexistent");
		assertThat(found).isNotPresent();
	}

	@Test
	public void BannerRepository_UpdateBanner_Success() {
		Banner banner = new Banner();
		banner.setName("Featured Banner");
		bannerRepository.save(banner);

		Optional<Banner> found = bannerRepository.findByName("Featured Banner");

		Banner updatedBanner = found.get();
		updatedBanner.setName("Updated Banner");
		updatedBanner.setImageUrl("https://example.com/updated.jpg");
		updatedBanner.setImageType("png");
		bannerRepository.save(updatedBanner);

		Optional<Banner> foundUpdated = bannerRepository
			.findById(updatedBanner.getId());
		assertThat(foundUpdated).isPresent();
		assertThat(foundUpdated.get().getName()).isEqualTo("Updated Banner");
		assertThat(foundUpdated.get().getImageUrl())
			.isEqualTo("https://example.com/updated.jpg");
		assertThat(foundUpdated.get().getImageType()).isEqualTo("png");
	}

	@Test
	public void BannerRepository_DeleteBanner_Success() {
		Banner banner = new Banner();
		banner.setName("Outdated Banner");
		bannerRepository.save(banner);

		bannerRepository.deleteById(banner.getId());

		Optional<Banner> found = bannerRepository.findById(banner.getId());
		assertThat(found).isNotPresent();
	}
}
