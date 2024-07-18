package com.funix.foodsaveradmin.repositories;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import com.funix.foodsaveradmin.models.Banner;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.Optional;

@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
public class BannerRepositoryTest {

    @Autowired
    private IBannerRepository bannerRepository;

    @Test
    public void testSaveBanner() {
        // Create a new banner and save it to the repository
        Banner banner = new Banner();
        banner.setName("Promo Banner");
        banner.setImageUrl("https://example.com/banner.jpg");
        banner.setImageType("jpg");
        bannerRepository.save(banner);

        // Retrieve the banner by name
        Optional<Banner> found = bannerRepository.findByName("Promo Banner");

        // Verify the banner was saved correctly
        assertThat(found).isPresent();
        assertThat(found.get().getName()).isEqualTo("Promo Banner");
        assertThat(found.get().getImageUrl()).isEqualTo("https://example.com/banner.jpg");
        assertThat(found.get().getImageType()).isEqualTo("jpg");
    }

    @Test
    public void testFindByName() {
        // Create and save a new banner
        Banner banner = new Banner();
        banner.setName("Sale Banner");
        bannerRepository.save(banner);

        // Retrieve the banner by name
        Optional<Banner> found = bannerRepository.findByName("Sale Banner");

        // Verify the banner was found and the name is correct
        assertThat(found).isPresent();
        assertThat(found.get().getName()).isEqualTo("Sale Banner");
    }

    @Test
    public void testFindByName_NotFound() {
        // Attempt to find a banner that doesn't exist
        Optional<Banner> found = bannerRepository.findByName("Nonexistent");

        // Verify no banner is found
        assertThat(found).isNotPresent();
    }

    @Test
    public void testFindById() {
        // Create and save a new banner
        Banner banner = new Banner();
        banner.setName("Special Offer Banner");
        bannerRepository.save(banner);

        // Retrieve the banner by ID
        Optional<Banner> found = bannerRepository.findById(banner.getId());

        // Verify the banner was found and the ID is correct
        assertThat(found).isPresent();
        assertThat(found.get().getId()).isEqualTo(banner.getId());
    }

    @Test
    public void testUpdateBanner() {
        // Create and save a new banner
        Banner banner = new Banner();
        banner.setName("Featured Banner");
        bannerRepository.save(banner);

        // Retrieve the banner by name
        Optional<Banner> found = bannerRepository.findByName("Featured Banner");

        // Update the banner's details
        Banner updatedBanner = found.get();
        updatedBanner.setName("Updated Banner");
        updatedBanner.setImageUrl("https://example.com/updated.jpg");
        updatedBanner.setImageType("png");
        bannerRepository.save(updatedBanner);

        // Verify the banner was updated correctly
        Optional<Banner> foundUpdated = bannerRepository.findById(updatedBanner.getId());
        assertThat(foundUpdated).isPresent();
        assertThat(foundUpdated.get().getName()).isEqualTo("Updated Banner");
        assertThat(foundUpdated.get().getImageUrl()).isEqualTo("https://example.com/updated.jpg");
        assertThat(foundUpdated.get().getImageType()).isEqualTo("png");
    }

    @Test
    public void testDeleteBanner() {
        // Create and save a new banner
        Banner banner = new Banner();
        banner.setName("Outdated Banner");
        bannerRepository.save(banner);

        // Delete the banner
        bannerRepository.deleteById(banner.getId());

        // Verify the banner was deleted
        Optional<Banner> found = bannerRepository.findById(banner.getId());
        assertThat(found).isNotPresent();
    }
}
