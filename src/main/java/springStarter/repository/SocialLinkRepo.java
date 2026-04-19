package springStarter.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import springStarter.models.SocialLinks;

@Repository
public interface SocialLinkRepo extends JpaRepository<SocialLinks, Long> {
	
	SocialLinks findByPlatform(String platform);
	
	Optional<SocialLinks> findByInstaId(Long instaId);

}
