package springStarter.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import springStarter.models.Banner;

public interface BannerRepo extends JpaRepository<Banner, Long>{

	Banner findTopByOrderByBannerIdDesc();

	Optional<Banner> findByBannerId(Long bannerId);
	
	

}
